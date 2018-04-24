module Api
  module V2
    class HomeController < Api::V2::ApplicationController
      before_action :authenticate_request!

      def index
        render json: { logged_id: true }
      end
    end
  end
end