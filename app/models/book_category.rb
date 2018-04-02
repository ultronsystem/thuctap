class BookCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book

  validates_associated :category, :book
end
