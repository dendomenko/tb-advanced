module Api
  module V2
    class MoviesController < Api::V2::ApplicationController
      def index
        render json: Movie.all.order(:created_at)
      end

      def show
        render json: Movie.find(params[:id])
      end
    end
  end
end
