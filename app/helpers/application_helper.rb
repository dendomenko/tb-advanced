module ApplicationHelper
  def display_voted(content)
    'display: none' unless content.voted? current_user
  end
end
