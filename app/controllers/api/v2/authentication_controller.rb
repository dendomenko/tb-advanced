module Api
  module V2
    class AuthenticationController < Api::V2::ApplicationController
      def authenticate_user
        user = User.find_for_database_authentication(email: params[:email])
        if user&.valid_password?(params[:password])
          render json: payload(user)
        else
          render json: { error: 'Invalid Username/Password' }, status: :unauthorized
        end
      end

      def sign_up
        user = User.find_for_database_authentication(email: params[:email])
        if user
          render json: { error: 'Email address is already taken by somebody' }, status: 403
        else
          user = User.new(sign_up_params)
          user.save
          render json: payload(user)
        end
      end

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation)
      end

      def payload(user)
        return nil unless user&.id
        {
            auth_token: JsonWebToken.encode({ user_id: user.id }),
            user: { id: user.id, email: user.email }
        }
      end
    end
  end
end
