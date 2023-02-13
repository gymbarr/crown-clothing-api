# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PRODUCT_COLORS = %w[black white yellow blue green grey purple brown pink red].freeze
PRODUCT_SIZES = (40..60).to_a

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

hats.image.attach(io: Rails.root.join('app/assets/images/categories/hats.png').open, filename: 'hats.png',
                  content_type: 'image/png')
jackets.image.attach(io: Rails.root.join('app/assets/images/categories/jackets.png').open, filename: 'jackets.png',
                     content_type: 'image/png')
sneakers.image.attach(io: Rails.root.join('app/assets/images/categories/sneakers.png').open, filename: 'sneakers.png',
                      content_type: 'image/png')
womens.image.attach(io: Rails.root.join('app/assets/images/categories/womens.png').open, filename: 'womens.png',
                    content_type: 'image/png')
mens.image.attach(io: Rails.root.join('app/assets/images/categories/mens.png').open, filename: 'mens.png',
                  content_type: 'image/png')

def random_items(array)
  array.sample(1 + rand(array.count))
end

def create_product(category, image_url, filename)
  title = Faker::Commerce.product_name
  price = Faker::Commerce.price(range: 0..1000)

  Product.create(title:, price:, category:)
         .image.attach(io: Rails.root.join(image_url).open, filename:, content_type: 'image/png')

  # colors = random_items(PRODUCT_COLORS)
  # colors.each do |color|
  #   sizes = random_items(PRODUCT_SIZES)
  #   sizes.each do |size|
  #     Variant.create(color:, size: size.to_s, product: Product.last)
  #   end
  # end
end

5000.times do
  create_product(hats, 'app/assets/images/products/hats/brown-brim.png', 'brown-brim.png')
  create_product(hats, 'app/assets/images/products/hats/blue-beanie.png', 'blue-beanie.png')
  create_product(hats, 'app/assets/images/products/hats/brown-cowboy.png', 'brown-cowboy.png')
  create_product(hats, 'app/assets/images/products/hats/grey-brim.png', 'grey-brim.png')
  create_product(hats, 'app/assets/images/products/hats/green-beanie.png', 'green-beanie.png')
  create_product(hats, 'app/assets/images/products/hats/palm-tree-cap.png', 'palm-tree-cap.png')
  create_product(hats, 'app/assets/images/products/hats/red-beanie.png', 'red-beanie.png')
  create_product(hats, 'app/assets/images/products/hats/wolf-cap.png', 'wolf-cap.png')
  create_product(hats, 'app/assets/images/products/hats/blue-snapback.png', 'blue-snapback.png')
end

5000.times do
  create_product(sneakers, 'app/assets/images/products/sneakers/adidas-nmd.png', 'adidas-nmd.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/yeezy.png', 'yeezy.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/black-converse.png', 'black-converse.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/white-nike-high-tops.png', 'white-nike-high-tops.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/nikes-red.png', 'nikes-red.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/nike-brown.png', 'nike-brown.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/nike-funky.png', 'nike-funky.png')
  create_product(sneakers, 'app/assets/images/products/sneakers/timberlands.png', 'timberlands.png')
end

5000.times do
  create_product(jackets, 'app/assets/images/products/jackets/black-shearling.png', 'black-shearling.png')
  create_product(jackets, 'app/assets/images/products/jackets/blue-jean-jacket.png', 'blue-jean-jacket.png')
  create_product(jackets, 'app/assets/images/products/jackets/grey-jean-jacket.png', 'grey-jean-jacket.png')
  create_product(jackets, 'app/assets/images/products/jackets/brown-shearling.png', 'brown-shearling.png')
  create_product(jackets, 'app/assets/images/products/jackets/brown-trench.png', 'brown-trench.png')
end

5000.times do
  create_product(womens, 'app/assets/images/products/womens/blue-tank.png', 'blue-tank.png')
  create_product(womens, 'app/assets/images/products/womens/floral-blouse.png', 'floral-blouse.png')
  create_product(womens, 'app/assets/images/products/womens/floral-skirt.png', 'floral-skirt.png')
  create_product(womens, 'app/assets/images/products/womens/red-polka-dot-dress.png', 'red-polka-dot-dress.png')
  create_product(womens, 'app/assets/images/products/womens/striped-sweater.png', 'striped-sweater.png')
  create_product(womens, 'app/assets/images/products/womens/yellow-track-suit.png', 'yellow-track-suit.png')
  create_product(womens, 'app/assets/images/products/womens/white-vest.png', 'white-vest.png')
end

5000.times do
  create_product(mens, 'app/assets/images/products/mens/camo-vest.png', 'camo-vest.png')
  create_product(mens, 'app/assets/images/products/mens/floral-shirt.png', 'floral-shirt.png')
  create_product(mens, 'app/assets/images/products/mens/long-sleeve.png', 'long-sleeve.png')
  create_product(mens, 'app/assets/images/products/mens/pink-shirt.png', 'pink-shirt.png')
  create_product(mens, 'app/assets/images/products/mens/roll-up-jean-shirt.png', 'froll-up-jean-shirt.png')
  create_product(mens, 'app/assets/images/products/mens/polka-dot-shirt.png', 'polka-dot-shirt.png')
end

Category.__elasticsearch__.create_index!
Product.__elasticsearch__.create_index!
