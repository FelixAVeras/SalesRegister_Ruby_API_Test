class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  has_many :created_products, class_name: 'Product', foreign_key: :creator_id
  has_many :created_categories, class_name: 'Category', foreign_key: :creator_id
end