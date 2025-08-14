class AdminUser < ApplicationRecord
    has_many :products, foreign_key: 'creator_id', class_name: 'Product'
    has_many :categories, foreign_key: 'creator_id', class_name: 'Category'
  
    has_many :sales

    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
