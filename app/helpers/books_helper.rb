module BooksHelper
  def load_books
    @list_books = Book.alpha.paginate page: params[:page], per_page: 8
  end
end
