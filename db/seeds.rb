# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Eliminando datos previos..."
Purchase.destroy_all
Product.destroy_all
Category.destroy_all
Client.destroy_all
User.destroy_all

puts "Creando administradores..."
admin_users = []
3.times do |i|
  admin_users << User.create!(
    email: "admin#{i+1}@example.com",
    password: "password123",
    role: "admin" # asumiendo que tienes un campo role
  )
end

puts "Creando categorías..."
categories = []
10.times do
  categories << Category.create!(
    name: Faker::Commerce.department(max: 1, fixed_amount: true),
    created_by: admin_users.sample.id # suponiendo campo created_by
  )
end

puts "Creando productos..."
products = []
10.times do
  product = Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 10),
    price: Faker::Commerce.price(range: 10..500),
    created_by: admin_users.sample.id
  )

  # Asignar de 1 a 3 categorías aleatorias
  product.categories << categories.sample(rand(1..3))

  # Simular imágenes (si usas ActiveStorage)
  2.times do
    product.images.attach(
      io: File.open(Rails.root.join("app/assets/images/sample.jpg")), # imagen ejemplo
      filename: "sample.jpg"
    )
  end

  products << product
end

puts "Creando clientes..."
clients = []
10.times do
  clients << Client.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone
  )
end

puts "Creando compras..."
20.times do
  Purchase.create!(
    product: products.sample,
    client: clients.sample,
    quantity: rand(1..5),
    total_price: Faker::Commerce.price(range: 10..500)
  )
end

puts "Datos de prueba creados con éxito ✅"