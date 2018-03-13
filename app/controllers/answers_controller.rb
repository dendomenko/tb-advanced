class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, except: %i[new create]

  after_action :publish_answer, only: :create

  include Voted
  include Commented

  respond_to :js

  def create
    @answer_form = AnswerForm.new(current_user, @question)
    authorize(@answer_form.answer)
    respond_with(@answer_form.submit(params))
  end

  def destroy
    authorize @answer
    respond_with(@answer.destroy)
  end

  def update
    respond_with(@answer.update(answer_params))
  end

  def best
    @answer.make_best
  end

  private

  def publish_answer
    return unless @answer_form.valid?
    ActionCable.server.broadcast(
      "question-#{@question.id}",
      @answer_form.answer.as_json(
        only: [:id, :body, :question_id, :rating, :user_id],
        methods: :question_author_id,
        include: :attachments
      )
    )
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end
end
