module QuestionsHelper
  def subscription_link(question)
    return unless current_user
    subscription = question.subscriptions.find_by_user_id(current_user.id)
    if subscription
      link_to question_subscription_path(question, subscription), method: :delete, class: 'subscribe-question' do
        content_tag(:span, '', class: 'oi oi-ban', data: {toggle: "tooltip", placement: "right"}, title: "Unsubscribe for updates")
      end
    else
      link_to question_subscriptions_path(question), method: :post, class: 'subscribe-question' do
        content_tag(:span, '', class: 'oi oi-envelope-open', data: {toggle: "tooltip", placement: "right"}, title: "Subscribe from updates")
      end
    end
  end
end
