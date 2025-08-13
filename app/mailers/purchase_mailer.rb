class PurchaseMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def first_purchase_email(purchase_id)
    purchase = Purchase.find(purchase_id)
    product = purchase.product
    creator = product.created_by
    admins = User.where(role: 'admin').where.not(id: creator.id)

    @product = product
    @purchase = purchase
    @creator = creator
    @admins = admins

    mail(
      to: creator.email,
      cc: admins.pluck(:email),
      subject: "¡Primera compra registrada de #{@product.name}!"
    )
  end
end
