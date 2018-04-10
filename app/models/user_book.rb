class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: {no_mark: 0, reading: 1, read: 2}

  scope :get_status, ->(book_id,user_id) do
    where("book_id = #{book_id} AND user_id = #{user_id}")
  end
end
