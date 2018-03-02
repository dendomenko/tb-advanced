class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question
  before_action :set_answer, except: %i[new create]
  before_action :author?, only: %i[destroy update]

  after_action :publish_answer, only: :create

  include Voted
  include Commented

  def show; end

  def new
    @answer_form = AnswerForm.new(current_user, @question)
  end

  def create
    @answer_form = AnswerForm.new(current_user, @question)
    @answer_form.submit(params)
  end

  def destroy
    @answer.destroy
  end

  def update
    @answer.update(answer_params)
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
      # question_id: @question.id,
      # question_author_id: @question.user_id,
      # answer_id: @answer_form.answer.id,
      # body: @answer_form.answer.body,
      # rating: @answer_form.answer.rating,
      # user_id: @answer_form.answer.user_id,
      # attachments: @answer_form.answer.attachments
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
