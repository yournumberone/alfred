# frozen_string_literal: true

module Users
  # callbacks controller
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!

    before_action :guild_member?

    def discord
      user = from_omniauth(request.env['omniauth.auth'])
      sign_in(user)

      redirect_to_back_or_edit(user)
    end

    private

    def guild_member?
      token = request.env['omniauth.auth'].credentials.token
      response = HTTParty.get('https://discord.com/api/users/@me/guilds',
                              headers: { 'Authorization': "Bearer #{token}" })
      return if response.any? { |h| h['id'] == ENV.fetch('DISCORD_SERVER_ID') }

      redirect_to new_session_url, notice: t('non_cg_alert')
    end

    def from_omniauth(auth)
      User.find_or_initialize_by(email: auth.info.email).tap do |user|
        user.uid = auth.uid
        fill_fullname(auth, user) if [user.first_name, user.last_name].any?(&:blank?)

        user.save
      end
    end

    def fill_fullname(auth, user)
      fullname = auth.info.name.split(/[.\s]/, 2)
      user.first_name, user.last_name = fullname.size == 2 ? fullname : [*fullname, '']
    end

    def redirect_to_back_or_edit(user)
      if [user.first_name, user.last_name].any?(&:blank?) && user.sign_in_count <= 1
        flash[:alert] = t('update_profile')
        redirect_to edit_user_path(user)
      else
        redirect_to after_sign_in_path_for(user)
      end
    end
  end
end
