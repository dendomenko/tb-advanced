module Api
  module V2
    class MoviesController < Api::V2::ApplicationController
      before_action :authenticate_request!, only: :rate

      def index
        render json: Movie.all.order(:created_at)
      end

      def show
        render json: Movie.find(params[:id])
      end

      def rate
        rate = @current_user.movie_ratings.create(movie_id: params[:id], rating: params[:rating])
        if rate.save
          render json: { rating: Movie.find(params[:id]).movie_ratings.average(:rating) || 0 }
        else
          render json: { error: rate.errors }
        end
      end
    end
  end
end
