class BuyRequest < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true

  scope :newest_of_user, ->(user_id) do
    where("user_id = #{user_id}").order created_at: :desc
  end
end
