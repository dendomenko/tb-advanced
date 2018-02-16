class AnswersController < ApplicationController
  before_action :set_question
  def index
    @answers = @question.answers
  end

  def show
    @answer = @question.answers.find(params[:id])
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to [@question, @answer]
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
