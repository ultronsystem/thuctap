class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token

  has_many :active_relationships, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :buy_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :fullname, presence: {accept: true, message: "không được để trống"}
  validates :fullname, length: { maximum: 50, message: "không được vượt quá 50 ký tự" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: {accept: true, message: "không được để trống"}, length: { maximum: 255, message: "không được vượt quá 255 ký tự" },
  format: { with: VALID_EMAIL_REGEX, message: "không đúng định dạng" },
  uniqueness: { case_sensitive: false, message: "đã được sử dụng để đăng ký tài khoản" }
  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end
end
