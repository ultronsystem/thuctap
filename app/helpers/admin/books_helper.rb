module Admin
  module BooksHelper
    def load_categories
      @categories = Category.all.collect{|x| [x.name_cat, x.id]}
    end
  end
end
