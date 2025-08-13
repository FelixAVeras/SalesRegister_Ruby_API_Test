class FirstPurchaseNotificationJob < ApplicationJob
  queue_as :mailers

  def perform(*args)
    purchase = Purchase.find(purchase_id)
    product = purchase.product

    # Verificar si es la primera compra
    if product.purchases.count == 1
      PurchaseMailer.first_purchase_email(purchase_id).deliver_now
    end
  end
end
