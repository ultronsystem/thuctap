module Admin
  class AdminController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user

    layout "admin"

    private

    def admin_user
      return if current_user.is_admin?
      flash[:danger] = "Từ chối truy cập"
      redirect_to root_url
    end
  end
end
