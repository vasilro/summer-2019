class User < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  has_secure_password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
