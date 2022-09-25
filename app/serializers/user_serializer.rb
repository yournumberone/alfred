class UserSerializer
  include FastJsonapi::ObjectSerializer

  extend Rails.application.routes.url_helpers

  attributes :id, :uid, :first_name, :last_name, :email, :dob

  attribute :avatar do |user|
    user.avatar.service_url
  end
end
