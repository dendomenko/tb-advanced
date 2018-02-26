module ApplicationHelper
  def display_voted(content)
    if content.voted? current_user
      ''
    else
      'display: none'
    end
  end
end
