# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: %i[show edit update destroy deactivate activate]
    before_action :set_application_names, only: %i[edit new]
    before_action :prevent_empty_params, only: %i[update]

    layout 'doorkeeper/admin'

    def index
      @users = User.all.includes(:oauth_applications)
      @active_users = User.all.where(deactivated_at: nil)
      @deactivated_users = User.all.where.not(deactivated_at: nil)
    end

    def show; end

    def edit; end

    def new
      @user = User.new
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user),
                    notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def destroy
      flash[:notice] = 'User was deleted.' if @user.destroy
      redirect_to admin_users_path
    end

    def deactivate
      if @user.update(oauth_application_ids: [], deactivated_at: DateTime.now)
        redirect_to admin_user_path(@user),
                    notice: 'User was successfully deactivated.'
      else
        redirect_back(fallback_location: root_path)
      end
    end

    def activate
      if @user.update(deactivated_at: nil)
        redirect_to admin_user_path(@user),
                    notice: 'User was successfully activated.'
      else
        redirect_back(fallback_location: root_path)
      end
    end

    private

    def prevent_empty_params
      params[:user][:oauth_application_ids] ||= []
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :dob, :avatar,
                                   :email, oauth_application_ids: [])
    end

    def set_application_names
      @applications = OauthApplication.select(:name, :id)
      @user_application_names = @user&.oauth_applications&.pluck(:name) || []
    end
  end
end
