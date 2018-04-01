class RequestBooksController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    redirect_to user_buy_requests_path(current_user.id)
  end
end
