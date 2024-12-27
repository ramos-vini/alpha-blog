class User < ApplicationRecord
  validates :username, presence: true, length: {minimum: 3, maximum: 20}
  validates :email, presence: true, length: {maximum: 100}, email: true
end