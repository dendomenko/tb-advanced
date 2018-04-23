module Api
  module V2
    class MoviesController < Api::V2::ApplicationController
      def index
        render json: Movie.all
      end

      def show
        render json: Movie.find(params[:id])
      end
    end
  end
end
