class AppAdmission < ApplicationRecord
  belongs_to :oauth_application
  belongs_to :user
end
