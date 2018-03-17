class BooksController < ApplicationController
  before_action :find_book, only: :show
  def index

  end

  def show
    @reviews = @book.reviews.newest
    @reviews = collection_paginate @reviews, params[:page], 5
    book_star @book
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = "Không tìm thấy sách"
    redirect_to root_path
  end
end
