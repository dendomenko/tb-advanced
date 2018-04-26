class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @subscription = @question.subscriptions.create(user_id: current_user.id)
    @subscription.save
    render json: {subscription_id: @subscription.id}
    # redirect_to @question, notice: 'Subscribed for question updates'
  end

  def destroy
    @subscription = @question.subscriptions.find_by_user_id(current_user.id)
    @subscription.destroy
    # redirect_to @question, notice: 'Unsubscribed for question updates'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
