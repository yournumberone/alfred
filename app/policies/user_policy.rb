# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def delete?
    user.admin?
  end

  def edit_access?
    user.admin?
  end

  def invite_from_ui?
    user.admin?
  end

  def deactivate?
    (user.admin? && !record.admin?) && record.deactivated_at.nil?
  end

  def activate?
    (user.admin? && !record.admin?) && !record.deactivated_at.nil?
  end
end
