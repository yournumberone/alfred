# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  skip_before_action :authenticate_user!, only: %i[invite_self magic_login]
  skip_before_action :store_user_location!, only: :edit

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to after_sign_in_path_for(@user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def invite
    UserInviter.new(params[:email]).invite
    flash[:notice] = 'The link was sent'
    redirect_to admin_users_path
  end

  def invite_self
    if UserInviter.new(params[:email]).invite
      flash[:notice] = 'The link was sent to your email'
    else
      flash[:alert] = 'This e-mail is not present in our DB'
    end
    redirect_to root_path
  end

  def magic_login
    user = User.where(magic_link_token: params[:token]).first
    if user
      user.update(magic_link_token: nil)
      sign_in(user, scope: :user)
      redirect_to user_path(user)
    else
      flash[:alert] = 'Your token is invalid'
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :dob, :avatar, :email)
  end
end
