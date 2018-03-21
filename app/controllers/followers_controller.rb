class FollowersController < ApplicationController
  before_action :logged_in_user
  before_action :find_user

  def index
    @users = @user.followers.paginate page: params[:page]
  end

  private

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:danger] = t ".user_not_found"
    redirect_to current_user
  end
end
