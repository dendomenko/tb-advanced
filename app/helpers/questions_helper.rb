module QuestionsHelper
  def subscription_link(question)
    return unless current_user
    subscription = question.subscriptions.find_by_user_id(current_user.id)
    if subscription
      link_to octicon('stop', height: 24), question_subscription_path(question, subscription), method: :delete, class: 'subscribe-question'
    else
      link_to octicon('mail', height: 24), question_subscriptions_path(question), method: :post, class: 'subscribe-question'
    end
  end
end
