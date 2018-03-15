class QuestionsController < ApplicationController
  before_action :load_question, only: %i[show destroy update vote unvote]

  after_action :publish_question, only: [:create]

  include Voted
  include Commented

  respond_to :html, except: [:update]
  respond_to :js, only: [:update]

  def index
    @questions = Question.all
    respond_with(authorize(@questions))
  end

  def show
    respond_with(@answer_form = AnswerForm.new(current_user, @question))
  end

  def new
    @question_form = QuestionForm.new(current_user)
    authorize(@question_form.question)
    respond_with(@question_form)
  end

  def create
    @question_form = QuestionForm.new(current_user)
    authorize(@question_form.question)
    if @question_form.submit(params)
      redirect_to @question_form.question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    authorize @question
    respond_with(@question.destroy)
  end

  def update
    respond_with(@question.update(question_params))
  end

  private

  def publish_question
    return unless @question_form.valid?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question_cable',
        locals: { question: @question_form.question }
      )
    )
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: %i[file _destroy])
  end
end
