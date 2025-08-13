class DailyReportMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def daily_purchase_report(date)
    @date = date
    @products = Product.includes(:purchases).map do |p|
      {
        product: p,
        purchases: p.purchases.where(created_at: @date.beginning_of_day..@date.end_of_day)
      }
    end

    admins = User.where(role: 'admin')
    mail(
      to: admins.pluck(:email),
      subject: "Reporte diario de compras - #{@date.strftime('%d/%m/%Y')}"
    )
  end
end
