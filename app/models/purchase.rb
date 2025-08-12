class Purchase < ApplicationRecord
  has_paper_trail
  belongs_to :product
  belongs_to :customer

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  after_commit :notify_admins_if_first_purchase, on: :create

  def total_amount
    unit_price * quantity
  end

  private

  def notify_admins_if_first_purchase
    if product.purchases.where('created_at < ?', created_at).none?
      FirstPurchaseMailerJob.perform_later(self.id)
    end
  end
end