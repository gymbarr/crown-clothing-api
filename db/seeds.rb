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

10.times do
  FactoryBot.create(:user)
end
hats = Category.create(title: 'hats', image_url: 'https://i.ibb.co/cvpntL1/hats.png')
jackets = Category.create(title: 'jackets', image_url: 'https://i.ibb.co/px2tCc3/jackets.png')
sneakers = Category.create(title: 'sneakers', image_url: 'https://i.ibb.co/0jqHpnp/sneakers.png')
womens = Category.create(title: 'womens', image_url: 'https://i.ibb.co/GCCdy8t/womens.png')
mens = Category.create(title: 'mens', image_url: 'https://i.ibb.co/R70vBrQ/men.png')

hats.image.attach(io: Rails.root.join('app/assets/images/categories/hats.png').open, filename: 'hats.png', content_type: 'image/png')
jackets.image.attach(io: Rails.root.join('app/assets/images/categories/jackets.png').open, filename: 'jackets.png', content_type: 'image/png')
sneakers.image.attach(io: Rails.root.join('app/assets/images/categories/sneakers.png').open, filename: 'sneakers.png', content_type: 'image/png')
womens.image.attach(io: Rails.root.join('app/assets/images/categories/womens.png').open, filename: 'womens.png', content_type: 'image/png')
mens.image.attach(io: Rails.root.join('app/assets/images/categories/mens.png').open, filename: 'mens.png', content_type: 'image/png')

Product.create(title: 'Brown Brim', image_url: 'https://i.ibb.co/ZYW3VTp/brown-brim.png', price: 25, category: hats)
Product.create(title: 'Blue Beanie', image_url: 'https://i.ibb.co/ypkgK0X/blue-beanie.png', price: 18, category: hats)
Product.create(title: 'Brown Cowboy', image_url: 'https://i.ibb.co/QdJwgmp/brown-cowboy.png', price: 35, category: hats)
Product.create(title: 'Grey Brim', image_url: 'https://i.ibb.co/RjBLWxB/grey-brim.png', price: 25, category: hats)
Product.create(title: 'Green Beanie', image_url: 'https://i.ibb.co/YTjW3vF/green-beanie.png', price: 18, category: hats)
Product.create(title: 'Palm Tree Cap', image_url: 'https://i.ibb.co/rKBDvJX/palm-tree-cap.png', price: 14, category: hats)
Product.create(title: 'Red Beanie', image_url: 'https://i.ibb.co/bLB646Z/red-beanie.png', price: 18, category: hats)
Product.create(title: 'Wolf Cap', image_url: 'https://i.ibb.co/1f2nWMM/wolf-cap.png', price: 14, category: hats)
Product.create(title: 'Blue Snapback', image_url: 'https://i.ibb.co/X2VJP2W/blue-snapback.png', price: 16, category: hats)

Product.create(title: 'Adidas NMD', image_url: 'https://i.ibb.co/0s3pdnc/adidas-nmd.png', price: 220, category: sneakers)
Product.create(title: 'Adidas Yeezy', image_url: 'https://i.ibb.co/dJbG1cT/yeezy.png', price: 280, category: sneakers)
Product.create(title: 'Black Converse', image_url: 'https://i.ibb.co/bPmVXyP/black-converse.png', price: 110, category: sneakers)
Product.create(title: 'Nike White AirForce', image_url: 'https://i.ibb.co/1RcFPk0/white-nike-high-tops.png', price: 160, category: sneakers)
Product.create(title: 'Nike Red High Tops', image_url: 'https://i.ibb.co/QcvzydB/nikes-red.png', price: 160, category: sneakers)
Product.create(title: 'Nike Brown High Tops', image_url: 'https://i.ibb.co/fMTV342/nike-brown.png', price: 160, category: sneakers)
Product.create(title: 'Air Jordan Limited', image_url: 'https://i.ibb.co/w4k6Ws9/nike-funky.png', price: 190, category: sneakers)
Product.create(title: 'Timberlands', image_url: 'https://i.ibb.co/Mhh6wBg/timberlands.png', price: 200, category: sneakers)

Product.create(title: 'Black Jean Shearling', image_url: 'https://i.ibb.co/XzcwL5s/black-shearling.png', price: 125, category: jackets)
Product.create(title: 'Blue Jean Jacket', image_url: 'https://i.ibb.co/mJS6vz0/blue-jean-jacket.png', price: 90, category: jackets)
Product.create(title: 'Grey Jean Jacket', image_url: 'https://i.ibb.co/N71k1ML/grey-jean-jacket.png', price: 90, category: jackets)
Product.create(title: 'Brown Shearling', image_url: 'https://i.ibb.co/s96FpdP/brown-shearling.png', price: 165, category: jackets)
Product.create(title: 'Tan Trench', image_url: 'https://i.ibb.co/M6hHc3F/brown-trench.png', price: 185, category: jackets)

Product.create(title: 'Blue Tanktop', image_url: 'https://i.ibb.co/7CQVJNm/blue-tank.png', price: 25, category: womens)
Product.create(title: 'Floral Blouse', image_url: 'https://i.ibb.co/4W2DGKm/floral-blouse.png', price: 20, category: womens)
Product.create(title: 'Floral Dress', image_url: 'https://i.ibb.co/KV18Ysr/floral-skirt.png', price: 80, category: womens)
Product.create(title: 'Red Dots Dress', image_url: 'https://i.ibb.co/N3BN1bh/red-polka-dot-dress.png', price: 80, category: womens)
Product.create(title: 'Striped Sweater', image_url: 'https://i.ibb.co/KmSkMbH/striped-sweater.png', price: 45, category: womens)
Product.create(title: 'Yellow Track Suit', image_url: 'https://i.ibb.co/v1cvwNf/yellow-track-suit.png', price: 135, category: womens)
Product.create(title: 'White Blouse', image_url: 'https://i.ibb.co/qBcrsJg/white-vest.png', price: 20, category: womens)

Product.create(title: 'Camo Down Vest', image_url: 'https://i.ibb.co/xJS0T3Y/camo-vest.png', price: 325, category: mens)
Product.create(title: 'Floral T-shirt', image_url: 'https://i.ibb.co/qMQ75QZ/floral-shirt.png', price: 20, category: mens)
Product.create(title: 'Black & White Longsleeve', image_url: 'https://i.ibb.co/55z32tw/long-sleeve.png', price: 80, category: mens)
Product.create(title: 'Pink T-shirt', image_url: 'https://i.ibb.co/RvwnBL8/pink-shirt.png', price: 25, category: mens)
Product.create(title: 'Jean Long Sleeve', image_url: 'https://i.ibb.co/VpW4x5t/roll-up-jean-shirt.png', price: 40, category: mens)
Product.create(title: 'Burgundy T-shirt', image_url: 'https://i.ibb.co/mh3VM1f/polka-dot-shirt.png', price: 25, category: mens)
