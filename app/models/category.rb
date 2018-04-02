class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories

  validates :name_cat, presence: {accept: true, message: "không được để trống"},
    length: {maximum: 100, message: "không được quá dài (tối đa 100 ký tự)"}

  scope :alpha, ->{order name_cat: :desc}
end
