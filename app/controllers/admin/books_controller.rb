module Admin
  class BooksController < AdminController
    before_action :find_book, except: %i(index new create)

    def index
      @books = Book.newest.paginate page: params[:page], per_page: 8
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new book_params
      if @book.save
        params[:book][:category_ids].each do |id_cat|
          @book.book_categories << BookCategory.new(category_id: id_cat) if id_cat.present?
        end
        flash[:sucess] = "Thêm thành công"
        redirect_to admin_books_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @book.update_attributes book_params
        @book.book_categories.clear
        params[:book][:category_ids].each do |id_cat|
          @book.book_categories << BookCategory.new(category_id: id_cat) if id_cat.present?
        end
        flash[:sucess] = "Cập nhập thành công"
        redirect_to admin_books_path
      else
        render :edit
      end
    end

    def destroy
      if @book.destroy
        flash[:success] = "Xóa thành công"
      else
        flash[:danger] = "Xóa không thành công"
      end
      redirect_to admin_books_path
    end

    private

    def book_params
      params.require(:book).permit :title, :author, :image, :publish_date, :number_of_pages, :summary, :category_ids
    end

    def find_book
      @book = Book.find_by id: params[:id]
      return if @book
      flash[:danger] = "Không tìm thấy sách"
      redirect_to admin_books_path
    end
  end
end
