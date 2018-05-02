module Api
  module V2
    class CommentsController < Api::V2::ApplicationController
      before_action :authenticate_request!

      def create
        comment = @current_user.comments.create(comment_params)
        render json: comment, status: :created
      end

      private

      def comment_params
        params.permit(:commentable_id, :commentable_type, :text)
      end
    end
  end
end
