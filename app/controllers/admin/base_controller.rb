class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    render_404 unless current_admin?
  end

  def toggle_enabled(user_id)
    user = User.find(user_id)
    user.switch_enabled

    flash[:success] = user.enabled? ?
      "#{user.name}'s account is now enabled." :
      "#{user.name}'s account is now disabled."
  end
end
