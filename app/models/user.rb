class User < ApplicationRecord
  has_many :article

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