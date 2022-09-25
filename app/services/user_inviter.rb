# frozen_string_literal: true

class UserInviter
  def initialize(email)
    @email = email
  end

  def invite
    @user = User.find_by(email: @email)
    return nil unless @user
    @user.update(magic_link_token: generate_token)
    send_mail
  end

  private

  def generate_token
    Devise.friendly_token.first(16)
  end

  def send_mail
    EmailLinkMailer.sign_in_mail(@user).deliver_now
  end
end
