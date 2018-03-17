module CategoriesHelper
  def list_cat
    @list_cat = Category.alpha
  end
end
