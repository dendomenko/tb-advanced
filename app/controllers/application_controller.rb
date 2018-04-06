require 'application_responder'

class ApplicationController < ActionController::Base
  include Pundit
  self.responder = ApplicationResponder
  respond_to :html, :json

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    error_msg = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    respond_to do |format|
      format.json { render json: { error: error_msg }, status: 403 }
      format.html do
        flash[:notice] = error_msg
        redirect_to(request.referrer || root_path)
      end
    end
  end
end
