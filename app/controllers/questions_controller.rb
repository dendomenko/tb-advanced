class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show destroy update]
  before_action :author?, only: %i[destroy update]
  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = current_user.questions.build
    @question.attachments.build
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question was successfully deleted.'
  end

  def update
    @question.update(question_params)
  end

  def vote

  end

  private

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
