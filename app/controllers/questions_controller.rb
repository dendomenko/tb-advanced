class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show destroy update vote unvote]
  before_action :author?, only: %i[destroy update]

  after_action :publish_question, only: [:create]

  include Voted
  include Commented

  def index
    @questions = Question.all
  end

  def show
    # @answer = @question.answers.build
    @answer_form = AnswerForm.new('current_user', @question)
  end

  def new
    # @question = current_user.questions.build
    # @question.attachments.build
    @question_form = QuestionForm.new('current_user')
  end

  def create
    @question_form = QuestionForm.new(current_user)
    if @question_form.submit(params)
      redirect_to @question_form.question, notice: 'Your question successfully created.'
    else
      render :new
    end
    # @question = current_user.questions.new(question_params)
    # if @question.save
    #   redirect_to @question, notice: 'Your question successfully created.'
    # else
    #   render :new
    # end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question was successfully deleted.'
  end

  def update
    @question.update(question_params)
  end

  def upvote
    @vote = @votable.add_vote(current_user.id, 1)
    save_vote
  end

  private

  def publish_question
    return if @question_form.question.valid?
    ActionCable.server.broadcast(
        'questions',
        ApplicationController.render(
          partial: 'questions/question_cable',
          locals: { question: @question_form.question }
        )
    )
  end

  def author?
    return nil if @question.author? current_user
    redirect_to questions_path, notice: 'You are not author of this question!'
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy])
  end
end
