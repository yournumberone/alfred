class OauthApplication < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::Application
  has_many :app_admissions, dependent: :destroy
end
