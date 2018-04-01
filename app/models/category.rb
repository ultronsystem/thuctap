class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories
  validates :name_cat, presence: true, length: {maximum: 80}
  scope :alpha, ->{order name_cat: :desc}
end
