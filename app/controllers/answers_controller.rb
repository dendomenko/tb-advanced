class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question
  before_action :set_answer, except: %i[new create]
  before_action :author?, only: %i[destroy update]

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

  def vote
    @vote = @answer.add_vote(current_user.id, params[:rate])
    respond_to do |format|
      if @vote.save
        format.json { render json: @answer.rating }
      else
        format.json { render json: @vote.errors.messages.values, status: 422 }
      end
    end
  end

  def unvote
    @question.remove_vote(current_user.id)
    respond_to do |format|
      format.json { render json: @question.rating }
    end
  end

  private

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
