class User < ApplicationRecord
  before_save { self.email = email.downcase } 
  validates :name, presence: true, length: { maximum: 60 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6}, allow_nil: true #allow_nil => allow edit profile without entering new password

  has_many :user_cities
  has_many :cities, through: :user_cities

  extend FriendlyId
  friendly_id :email, use: :slugged

  def username
    self.email.split(/@/).first
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
