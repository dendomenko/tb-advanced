class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question
  before_action :set_answer, except: %i[new create]
  before_action :author?, only: %i[destroy update]

  after_action :publish_answer, only: :create

  include Voted
  include Commented

  respond_to :js

  def create
    @answer_form = AnswerForm.new(current_user, @question)
    respond_with(@answer_form.submit(params))
  end

  def destroy
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

  def author?
    return nil if @answer.author? current_user
    redirect_to question_path(@question), notice: 'You are not author of this answer!'
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
