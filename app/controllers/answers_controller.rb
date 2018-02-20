class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question
  before_action :set_answer, only: %i[show destroy]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy if @answer.author? current_user
    redirect_to question_path(@question),
                notice: 'Your answer was successfully deleted.'
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end
end
