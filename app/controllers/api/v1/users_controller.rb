module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :doorkeeper_authorize!

      def me
        render json: {
          id: current_resource_owner.id,
          uid: current_resource_owner.uid,
          first_name: current_resource_owner.first_name,
          last_name: current_resource_owner.last_name,
          email: current_resource_owner.email,
          dob: current_resource_owner.dob,
          avatar: current_resource_owner.avatar.service_url
        }.to_json
      end

      private

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
