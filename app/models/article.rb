class Article < ApplicationRecord
  belongs_to :user

  validates :title, 
            presence: true,
            length: {minimum: 5, maximum: 50}
  validates :description, 
            presence: true, 
            length: {minimum: 10, maximum: 100}
end