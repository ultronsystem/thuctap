class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :user_books
  has_many :categories, through: :book_categories
  mount_uploader :image, ImageUploader
  scope :cat_books, ->(cat_id) do
    joins(:book_categories).where("category_id = #{cat_id}").order("title")
  end

  scope :newest, ->{order created_at: :desc}
end
