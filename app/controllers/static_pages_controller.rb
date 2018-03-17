class StaticPagesController < ApplicationController
  def home
    @list_books = Book.newest.paginate page: params[:page], per_page: 8
  end
end
