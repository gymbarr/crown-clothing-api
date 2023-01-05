# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.find_or_create_by(email: 'g-barr@mail.ru') do |user|
  user.username = 'Andrey'
  user.password = 'password'
end

unless first_user.has_role?(Role.admin_user_role)
  first_user.add_role(Role.admin_user_role)
  first_user.remove_role(Role.basic_user_role)
end

User.find_or_create_by(email: 'andryuh2a@mail.ru') do |user|
  user.username = 'Andryuh2a'
  user.password = 'password'
end

100.times do
  FactoryBot.create(:user)
end

hats = Category.create(title: 'hats')
jackets = Category.create(title: 'jackets')
sneakers = Category.create(title: 'sneakers')
womens = Category.create(title: 'womens')
mens = Category.create(title: 'mens')

hats.image.attach(io: Rails.root.join('app/assets/images/categories/hats.png').open, filename: 'hats.png', content_type: 'image/png')
jackets.image.attach(io: Rails.root.join('app/assets/images/categories/jackets.png').open, filename: 'jackets.png', content_type: 'image/png')
sneakers.image.attach(io: Rails.root.join('app/assets/images/categories/sneakers.png').open, filename: 'sneakers.png', content_type: 'image/png')
womens.image.attach(io: Rails.root.join('app/assets/images/categories/womens.png').open, filename: 'womens.png', content_type: 'image/png')
mens.image.attach(io: Rails.root.join('app/assets/images/categories/mens.png').open, filename: 'mens.png', content_type: 'image/png')

20.times do
  Product.create(title: 'Brown Brim', price: 25, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/brown-brim.png').open, filename: 'brown-brim.png', content_type: 'image/png')
  Product.create(title: 'Blue Beanie', price: 18, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/blue-beanie.png').open, filename: 'blue-beanie.png', content_type: 'image/png')
  Product.create(title: 'Brown Cowboy', price: 35, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/brown-cowboy.png').open, filename: 'brown-cowboy.png', content_type: 'image/png')
  Product.create(title: 'Grey Brim', price: 25, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/grey-brim.png').open, filename: 'grey-brim.png', content_type: 'image/png')
  Product.create(title: 'Green Beanie', price: 18, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/green-beanie.png').open, filename: 'green-beanie.png', content_type: 'image/png')
  Product.create(title: 'Palm Tree Cap', price: 14, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/palm-tree-cap.png').open, filename: 'palm-tree-cap.png', content_type: 'image/png')
  Product.create(title: 'Red Beanie', price: 18, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/red-beanie.png').open, filename: 'red-beanie.png', content_type: 'image/png')
  Product.create(title: 'Wolf Cap', price: 14, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/wolf-cap.png').open, filename: 'wolf-cap.png', content_type: 'image/png')
  Product.create(title: 'Blue Snapback', price: 16, category: hats)
         .image.attach(io: Rails.root.join('app/assets/images/products/hats/blue-snapback.png').open, filename: 'blue-snapback.png', content_type: 'image/png')
end

20.times do
  Product.create(title: 'Adidas NMD', price: 220, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/adidas-nmd.png').open, filename: 'adidas-nmd.png', content_type: 'image/png')
  Product.create(title: 'Adidas Yeezy', price: 280, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/yeezy.png').open, filename: 'yeezy.png', content_type: 'image/png')
  Product.create(title: 'Black Converse', price: 110, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/black-converse.png').open, filename: 'black-converse.png', content_type: 'image/png')
  Product.create(title: 'Nike White AirForce', price: 160, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/white-nike-high-tops.png').open, filename: 'white-nike-high-tops.png', content_type: 'image/png')
  Product.create(title: 'Nike Red High Tops', price: 160, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/nikes-red.png').open, filename: 'nikes-red.png', content_type: 'image/png')
  Product.create(title: 'Nike Brown High Tops', price: 160, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/nike-brown.png').open, filename: 'nike-brown.png', content_type: 'image/png')
  Product.create(title: 'Air Jordan Limited', price: 190, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/nike-funky.png').open, filename: 'nike-funky.png', content_type: 'image/png')
  Product.create(title: 'Timberlands', price: 200, category: sneakers)
         .image.attach(io: Rails.root.join('app/assets/images/products/sneakers/timberlands.png').open, filename: 'timberlands.png', content_type: 'image/png')
end

20.times do
  Product.create(title: 'Black Jean Shearling', price: 125, category: jackets)
         .image.attach(io: Rails.root.join('app/assets/images/products/jackets/black-shearling.png').open, filename: 'black-shearling.png', content_type: 'image/png')
  Product.create(title: 'Blue Jean Jacket', price: 90, category: jackets)
         .image.attach(io: Rails.root.join('app/assets/images/products/jackets/blue-jean-jacket.png').open, filename: 'blue-jean-jacket.png', content_type: 'image/png')
  Product.create(title: 'Grey Jean Jacket', price: 90, category: jackets)
         .image.attach(io: Rails.root.join('app/assets/images/products/jackets/grey-jean-jacket.png').open, filename: 'grey-jean-jacket.png', content_type: 'image/png')
  Product.create(title: 'Brown Shearling', price: 165, category: jackets)
         .image.attach(io: Rails.root.join('app/assets/images/products/jackets/brown-shearling.png').open, filename: 'brown-shearling.png', content_type: 'image/png')
  Product.create(title: 'Tan Trench', price: 185, category: jackets)
         .image.attach(io: Rails.root.join('app/assets/images/products/jackets/brown-trench.png').open, filename: 'brown-trench.png', content_type: 'image/png')
end

20.times do
  Product.create(title: 'Blue Tanktop', price: 25, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/blue-tank.png').open, filename: 'blue-tank.png', content_type: 'image/png')
  Product.create(title: 'Floral Blouse', price: 20, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/floral-blouse.png').open, filename: 'floral-blouse.png', content_type: 'image/png')
  Product.create(title: 'Floral Dress', price: 80, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/floral-skirt.png').open, filename: 'floral-skirt.png', content_type: 'image/png')
  Product.create(title: 'Red Dots Dress', price: 80, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/red-polka-dot-dress.png').open, filename: 'red-polka-dot-dress.png', content_type: 'image/png')
  Product.create(title: 'Striped Sweater', price: 45, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/striped-sweater.png').open, filename: 'striped-sweater.png', content_type: 'image/png')
  Product.create(title: 'Yellow Track Suit', price: 135, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/yellow-track-suit.png').open, filename: 'yellow-track-suit.png', content_type: 'image/png')
  Product.create(title: 'White Blouse', price: 20, category: womens)
         .image.attach(io: Rails.root.join('app/assets/images/products/womens/white-vest.png').open, filename: 'white-vest.png', content_type: 'image/png')
end

20.times do
  Product.create(title: 'Camo Down Vest', price: 325, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/camo-vest.png').open, filename: 'camo-vest.png', content_type: 'image/png')
  Product.create(title: 'Floral T-shirt', price: 20, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/floral-shirt.png').open, filename: 'floral-shirt.png', content_type: 'image/png')
  Product.create(title: 'Black & White Longsleeve', price: 80, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/long-sleeve.png').open, filename: 'long-sleeve.png', content_type: 'image/png')
  Product.create(title: 'Pink T-shirt', price: 25, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/pink-shirt.png').open, filename: 'pink-shirt.png', content_type: 'image/png')
  Product.create(title: 'Jean Long Sleeve', price: 40, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/roll-up-jean-shirt.png').open, filename: 'roll-up-jean-shirt.png', content_type: 'image/png')
  Product.create(title: 'Burgundy T-shirt', price: 25, category: mens)
         .image.attach(io: Rails.root.join('app/assets/images/products/mens/polka-dot-shirt.png').open, filename: 'polka-dot-shirt.png', content_type: 'image/png')
end
