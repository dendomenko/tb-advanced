class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment-question-#{params[:question_id]}"
  end
end
