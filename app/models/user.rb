class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :article

  has_secure_password

  validates :username, 
            presence: true,
            length: {minimum: 3, maximum: 20},
            uniqueness: true
            
  validates :email,
            presence: true, 
            length: {maximum: 100}, 
            email: true, 
            uniqueness: true
  
end