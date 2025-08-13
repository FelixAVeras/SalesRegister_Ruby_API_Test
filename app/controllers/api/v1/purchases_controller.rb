class Api::V1::PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :update, :destroy]

  def index
    purchases = Purchase.all
    render json: purchases, include: [:product, :client]
  end

  def show
    render json: @purchase, include: [:product, :client]
  end

  def create
    purchase = Purchase.new(purchase_params)
    if purchase.save
      FirstPurchaseNotificationJob.perform_later(purchase.id)
      render json: purchase, status: :created
    else
      render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @purchase.update(purchase_params)
      render json: @purchase
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase.destroy
    head :no_content
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:product_id, :client_id, :quantity, :total_price)
  end
end
