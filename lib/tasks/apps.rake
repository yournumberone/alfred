# frozen_string_literal: true

namespace :apps do
  desc 'Make all current apps accessible for all users'
  task grant_access: :environment do
    User.all.each do |user|
      user.update(oauth_applications: OauthApplication.all)
    end
  end
end
