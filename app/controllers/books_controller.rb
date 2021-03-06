class BooksController < ApplicationController
  before_action :find_book, only: :show
  def index
    if params[:search].blank?
      load_books
    else
      search_title_and_author
    end
  end

  def book_params
    params.permit :search, :search_for
  end

  def show
    find_book_mark(params[:id], current_user.id) if logged_in?
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

  def search_title_and_author
    @books = Book.search params[:search], params[:search_for]
    @books = collection_paginate @books, params[:page], Settings.books.per_page
    @title_search = t(".search.title_search") + "'#{params[:search]}'"
  end

  def find_book_mark book_id, user_id
    @user_book = UserBook.find_by book_id: book_id, user_id: user_id
    @notify_user_book = t ".notify_user_book" if @user_book.nil?
  end

  def load_books
    @books = Book.alpha
    @books = collection_paginate @books, params[:page], Settings.books.per_page
    @title_search = t ".all_books"
  end
end
