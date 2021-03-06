class User < ApplicationRecord
  has_secure_password
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum:3, maximum:25 }, 
            uniqueness: { case_sensitive: false }
            validates :email, presence: true, uniqueness: { case_sensitive: false },
            length: { maximum: 100 }, 
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end