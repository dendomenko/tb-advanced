module Api
  module V2
    class NewsController < Api::V2::ApplicationController
      def index
        render json: News.all.order(:created_at)
      end

      def show
        render json: News.find(params[:id])
      end
    end
  end
end

