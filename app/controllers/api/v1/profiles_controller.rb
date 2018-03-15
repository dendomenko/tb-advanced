module Api
  module V1
    class ProfilesController < Api::V1::ApiController
      def show
        respond_with(@users = User.where.not(id: current_resource_owner.id))
      end

      def me
        respond_with current_resource_owner
      end
    end
  end
end
