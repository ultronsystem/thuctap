class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  validates :content, presence: true

  scope :newest, ->{order created_at: :desc}
end
