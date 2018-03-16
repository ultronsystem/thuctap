class Activity < ApplicationRecord
  belongs_to :user

  scope :by_user, ->(user_id) do
    where("user_id = #{user_id}").order(created_at: :desc)
  end
  scope :in_public, ->(user_id) do
    where("user_id = #{user_id} and type_activity in ('comment','review')").order(created_at: :desc)
  end
end
