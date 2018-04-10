class CommentsController < ApplicationController
  before_action :find_review
  before_action :find_comment, only: %i(destroy edit update)
  before_action -> {check_login_or_save_url(book_review_path params[:book_id], params[:review_id])}

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.content.empty?
      flash[:warning] = "Hãy viết suy nghĩ của bạn vào phần nội dung bình luận."
    elsif @review.comments << @comment
      flash[:success] = "Đăng bình luận thành công!"
    else
      flash[:danger] = "Đăng bình luận thất bại."
    end
    redirect_to book_review_path params[:book_id], params[:review_id]
  end

  def update
    if @comment.update comment_params
      flash[:success] = "Chỉnh sửa bình luận thành công!"
    else
      flash[:danger] = "Chỉnh sửa bình luận thất bại, vui lòng kiểm tra lại!"
    end
    redirect_to book_review_path params[:book_id], params[:review_id]
  end

  def edit
    @book = Book.find_by id: params[:book_id]
    if @comment
      respond_to do |format|
        format.html {redirect_to @book, @review, @comment}
        format.js
      end
    else
      flash[:danger] = "Bình luận không được tìm thấy."
      redirect_to book_path(params[:book_id])
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = "Xóa bình luận thành công!"
    else
      flash[:danger] = "Xóa bình luận thất bại!"
    end
    redirect_to book_review_path params[:book_id], params[:review_id]
  end

  private

  def comment_params
    params.require(:comment).permit :review_id, :content
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
    if @review.nil?
      flash[:danger] = "Không tìm thấy bài đánh giá."
      redirect_to book_path(params[:book_id])
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end
