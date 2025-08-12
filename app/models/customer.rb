class Customer < ApplicationRecord
  has_many :purchases, dependent: :nullify
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end