class BooksController < ApplicationController
  before_action :find_book, only: :show
  def index

  end

  def show

  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = "Không tìm thấy sách"
    redirect_to root_path
  end
end
