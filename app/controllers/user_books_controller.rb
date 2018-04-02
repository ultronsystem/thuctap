  class UserBooksController < ApplicationController
  before_action :find_book
  before_action -> {check_login_or_save_url(book_path @book.id)}

  def create
    if params[:button] == "like"
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, is_favorite: true)
    elsif params[:button] == "read"
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, status: 2)
    else
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, status: 1)
    end
    if @user_book.save
      respond_to do |format|
        format.html{redirect_to @user_book, @book}
        format.js
      end
    else
      flash[:danger] = t ".mark_fail"
      redirect_to book_path(params[:book_id])
    end
  end

  def update
    @user_book = UserBook.find_by id: params[:id]
    is_favorite = params[:is_favorite]
    status = params[:status]
    if @user_book.update_attributes(is_favorite: is_favorite, status: status)
      respond_to do |format|
        format.html{redirect_to @user_book, @book}
        format.js
      end
    else
      flash[:danger] = t ".mark_fail"
      redirect_to book_path(params[:book_id])
    end
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = "Không tìm thấy sách"
    redirect_to root_path
  end

  def mark_like value_params
    value_params == "false"
  end

  def mark_read value_params_status, value_params_button
    if value_params_button == "read"
      if value_params_status != "read"
        return :read, (t ".read_book", book: @book.title), "read"
      else
        return :no_mark,(t ".unread_book", book: @book.title), "unread"
      end
    else
      if value_params_status != "reading"
        return :reading, (t ".reading_book", book: @book.title), "reading"
      else
        return :no_mark, (t ".unreading_book", book: @book.title), "unreading"
      end
    end
  end

  def active_favorite_book favorite
    if favorite == false
      return (t ".unlike_book", book: @book.title), "favorite"
    else
      return (t ".like_book", book: @book.title), "unfavorite"
    end
  end

  def new_value_content_and_type_activity
    if params[:button] == "like"
      return (t ".like_book", book: @book.title), "favorite"
    elsif params[:button] == "read"
      return (t ".read_book", book: @book.title), "read"
    else
      return (t ".reading_book", book: @book.title), "reading"
    end
  end
end
