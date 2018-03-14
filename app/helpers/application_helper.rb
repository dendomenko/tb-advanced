module ApplicationHelper
  def display_voted(content)
    'display: none' unless content.voted? current_user
  end

  def datetime(timestamp)
    timestamp.strftime('%Y %b %d %H:%M:%S')
  end
end
