class BuyRequestsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user
  before_action :load_request, only: :create
  before_action :find_request, only: :destroy

  def index
    if current_user? @user
      @buy_requests = BuyRequest.newest_of_user(params[:user_id]).paginate page: params[:page],
        per_page: Settings.buy_request.per_page
      @count_requests = @buy_requests.present? ? @buy_requests.count : 0
    else
      flash[:danger] = "Từ chối truy cập"
      redirect_to user_buy_requests_path current_user.id
    end
  end

  def new
    @buy_request = @current_user.buy_requests.build
  end

  def create
    @buy_request = current_user.buy_requests.build request_params
    if @buy_request.save
      flash[:success] = "Thêm thành công"
      redirect_to user_buy_requests_path
    else
      render :new
    end
  end

  def destroy
    if @buy_request.destroy
      flash[:success] = "Xóa thành công"
    else
      flash[:danger] = "Xóa thất bại"
    end
    redirect_to user_buy_requests_path current_user.id
  end

  private

  def request_params
    params.require(:buy_request).permit :title, :author, :user_id
  end

  def find_request
    @buy_request = BuyRequest.find_by id: params[:id]
    return if @buy_request
    flash[:danger] = "Không tìm thấy yêu cầu"
    redirect_to @buy_requests
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:danger] = "Không tìm thấy tài khoản"
    redirect_to root_path
  end

  def load_request
    @buy_request = BuyRequest.find_by title: params[:buy_request][:title],
      author: params[:buy_request][:author], user_id: params[:user_id]
    return unless @buy_request
    flash[:danger] = "Yêu cầu bỉ trùng"
    redirect_to user_buy_requests_path current_user.id
  end
end
