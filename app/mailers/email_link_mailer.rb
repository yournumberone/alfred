# frozen_string_literal: true

class EmailLinkMailer < ApplicationMailer
  def sign_in_mail(user)
    @user = user
    mail to: @user.email, subject: 'Here is your magic link for Alfred sign in!'
  end
end
