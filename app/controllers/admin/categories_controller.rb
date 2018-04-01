module Admin
  class CategoriesController < AdminController
    before_action :find_category, only: %i(edit destroy update)
    before_action :check_cat_exist, only: %i(create update)

    def index
      @categories = Category.paginate page: params[:page],
        per_page: 10
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = "Thêm thành công"
        redirect_to admin_categories_path
      else
        flash.now[:danger] =  "Thêm thất bại"
        render :new
      end
    end

    def edit; end

    def update
      if @category.update_attributes category_params
        flash[:success] = "Cập nhập thành công"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = "Cập nhập không thành công"
        render :edit
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = "Xóa thành công"
      else
        flash[:danger] = "Xóa không thành công"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit :name_cat
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:danger] = "Không tìm thấy thể loại"
      redirect_to admin_categories_path
    end

    def check_cat_exist
      name_cat = params[:category][:name_cat].strip
      @exist = Category.find_by name_cat: name_cat
      return unless @exist
      flash[:danger] = "Tên thể loại đã tồn tại"
      redirect_to new_admin_category_path
    end
  end
end
