class ReviewsController < ApplicationController
  before_action :logged_in_user, except: :show
  before_action :find_book
  before_action :check_review, only: :create
  before_action :find_review, except: %i(new create)
    before_action :correct_user,   only: [:edit, :update]

  def new
    @review = @book.reviews.build
  end

  def show
    find_comments @review
  end

  def create
    @review = current_user.reviews.build review_params
    if @book.reviews << @review
      # content = t ".add_review", title: @book.title, author: @book.author
      # new_activity current_user, content, @book.id, Settings.add_review
      flash[:success] = "Đăng bài thành công"
      redirect_to @book
    else
      render :new
    end
  end

  def edit;
  debugger end

  def update
    if @review.update_attributes review_params
      flash[:success] = "Cập nhập thành công"
      # content = t ".edit_review", title: @book.title, author: @book.author
      # new_activity current_user, content, @book.id, Settings.edit_review
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      # content = t ".destroy_review", title: @book.title, author: @book.author
      # new_activity current_user, content, @book.id, Settings.destroy_review
      flash[:success] = "Xóa thành công"
    else
      flash[:danger] = "Xóa không thành công"
    end
    redirect_to @book
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = "Không tim thấy sách"
    redirect_to root_path
  end

  def reviewed user_id, book_id
    review = Review.find_by user_id: user_id, book_id: book_id
    return unless review
    flash[:danger] = "Bạn đã đánh giá quyển sách này"
    redirect_to @book
  end

  def check_review
    reviewed current_user.id, params[:book_id]
  end

  def review_params
    params.require(:review).permit :content, :rate, :book_id
  end

  def find_review
    @review = Review.find_by id: params[:id]
    redirect_to root_url if @review.nil?
  end

  def find_comments review
    @comments = review.comments.paginate page: params[:page], per_page: Settings.comments.page_size
    return @notify_comment_empty = t(".notify_comment_empty") if @comments.empty?
  end
  def correct_user
      @user = User.find_by id: @review.user_id
      redirect_to(root_url) unless current_user?(@user)
    end
end
