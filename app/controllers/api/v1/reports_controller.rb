class Api::V1::ReportsController < ApplicationController
  # a. Productos más comprados por cada categoría
  def top_products_per_category
    data = Category.includes(:products).map do |category|
      top_products = category.products
        .joins(:purchases)
        .group('products.id')
        .order('COUNT(purchases.id) DESC')
        .limit(1) # el más comprado
        .select('products.*, COUNT(purchases.id) as purchases_count')

      {
        category_id: category.id,
        category_name: category.name,
        top_products: top_products.map { |p| { id: p.id, name: p.name, purchases_count: p.purchases_count.to_i } }
      }
    end

    render json: data
  end

  # b. 3 productos que más han recaudado por categoría
  def top_revenue_products_per_category
    data = Category.includes(:products).map do |category|
      top_products = category.products
        .joins(:purchases)
        .group('products.id')
        .order('SUM(purchases.total_price) DESC')
        .limit(3)
        .select('products.*, SUM(purchases.total_price) as revenue')

      {
        category_id: category.id,
        category_name: category.name,
        top_products: top_products.map { |p| { id: p.id, name: p.name, revenue: p.revenue.to_f } }
      }
    end

    render json: data
  end

  # c. Listado de compras según filtros
  def filtered_purchases
    purchases = Purchase.all
    purchases = purchases.where('created_at >= ?', params[:from]) if params[:from].present?
    purchases = purchases.where('created_at <= ?', params[:to]) if params[:to].present?
    purchases = purchases.joins(product: :categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    purchases = purchases.where(client_id: params[:client_id]) if params[:client_id].present?
    purchases = purchases.joins(:product).where(products: { created_by_id: params[:admin_id] }) if params[:admin_id].present?

    render json: purchases, include: [:product, :client]
  end

  # d. Cantidad de compras según granularidad
  def purchases_aggregate
    purchases = Purchase.all
    purchases = purchases.where('created_at >= ?', params[:from]) if params[:from].present?
    purchases = purchases.where('created_at <= ?', params[:to]) if params[:to].present?
    purchases = purchases.joins(product: :categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    purchases = purchases.where(client_id: params[:client_id]) if params[:client_id].present?
    purchases = purchases.joins(:product).where(products: { created_by_id: params[:admin_id] }) if params[:admin_id].present?

    granularity = params[:granularity] || 'day'

    grouped = case granularity
    when 'hour'
      purchases.group_by_hour(:created_at, format: "%Y-%m-%d %H:00").count
    when 'day'
      purchases.group_by_day(:created_at, format: "%Y-%m-%d").count
    when 'week'
      purchases.group_by_week(:created_at, format: "%Y-%m-%d").count
    when 'year'
      purchases.group_by_year(:created_at, format: "%Y").count
    else
      purchases.group_by_day(:created_at, format: "%Y-%m-%d").count
    end

    render json: grouped
  end
end
