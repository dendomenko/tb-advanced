class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question
  before_action :set_answer, except: %i[new create]
  before_action :author?, only: %i[destroy update]

  after_action :publish_ansewr, only: :create

  include Voted

  def show;
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy
    # redirect_to question_path(@question),
    #             notice: 'Your answer was successfully deleted.'
  end

  def update
    @answer.update(answer_params)
  end

  def best
    @answer.make_best
  end

  private

  def publish_ansewr
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "question-#{@question.id}",
      question_id: @question.id,
      question_author_id: @question.user_id,
      answer: {
        id: @answer.id,
        body: @answer.body,
        rating: @answer.rating,
        user_id: @answer.user_id,
        attachments: @answer.attachments
      }
    )
  end

  def author?
    return nil if @answer.author? current_user
    redirect_to question_path(@question), notice: 'You are not author of this answer!'
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end
end
