module QuestionsHelper
  def display_voted(question)
    if @question.voted? current_user
      ''
    else
      'display: none'
    end
  end
end
