class CategoriesController < ApplicationController
  before_action :find_cat

  def show
    @books = Book.cat_books(@category.id).paginate page: params[:page], per_page: 8
  end

  private

  def find_cat
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = "Không tìm thấy thể loại"
    redirect_to root_path
  end
end
