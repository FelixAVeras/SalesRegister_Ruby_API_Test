class Category < ApplicationRecord
  has_paper_trail
  belongs_to :creator, class_name: 'AdminUser'
  has_many :categorizations, dependent: :destroy
  has_many :products, through: :categorizations
  validates :name, presence: true, uniqueness: true
end
