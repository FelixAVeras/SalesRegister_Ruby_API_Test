class Product < ApplicationRecord
  has_paper_trail
  belongs_to :creator, class_name: 'AdminUser'
  has_many_attached :images
  has_many :purchases, dependent: :restrict_with_error

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end