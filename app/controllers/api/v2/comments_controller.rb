module Api
  module V2
    class CommentsController < Api::V2::ApplicationController
      before_action :authenticate_request!

      def create
        render json: { created: @current_user.comments.create(comment_params)}
      end

      private

      def comment_params
        params.permit(:commentable_id, :commentable_type, :text)
      end
    end
  end
end
