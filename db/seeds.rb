# frozen_string_literal: true

require 'benchmark'

PRODUCT_COLORS = %w[black white yellow blue green grey purple brown pink red].freeze
PRODUCT_SIZES = (40..60).to_a

HATS_IMAGES = [
  { path: 'app/assets/images/products/hats/brown-brim.png', filename: 'brown-brim.png' },
  { path: 'app/assets/images/products/hats/blue-beanie.png', filename: 'blue-beanie.png' },
  { path: 'app/assets/images/products/hats/brown-cowboy.png', filename: 'brown-cowboy.png' },
  { path: 'app/assets/images/products/hats/grey-brim.png', filename: 'grey-brim.png' },
  { path: 'app/assets/images/products/hats/green-beanie.png', filename: 'green-beanie.png' },
  { path: 'app/assets/images/products/hats/palm-tree-cap.png', filename: 'palm-tree-cap.png' },
  { path: 'app/assets/images/products/hats/red-beanie.png', filename: 'red-beanie.png' },
  { path: 'app/assets/images/products/hats/wolf-cap.png', filename: 'wolf-cap.png' },
  { path: 'app/assets/images/products/hats/blue-snapback.png', filename: 'blue-snapback.png' }
].freeze

SNEAKERS_IMAGES = [
  { path: 'app/assets/images/products/sneakers/adidas-nmd.png', filename: 'adidas-nmd.png' },
  { path: 'app/assets/images/products/sneakers/yeezy.png', filename: 'yeezy.png' },
  { path: 'app/assets/images/products/sneakers/black-converse.png', filename: 'black-converse.png' },
  { path: 'app/assets/images/products/sneakers/white-nike-high-tops.png', filename: 'white-nike-high-tops.png' },
  { path: 'app/assets/images/products/sneakers/nikes-red.png', filename: 'nikes-red.png' },
  { path: 'app/assets/images/products/sneakers/nike-brown.png', filename: 'nike-brown.png' },
  { path: 'app/assets/images/products/sneakers/nike-funky.png', filename: 'nike-funky.png' },
  { path: 'app/assets/images/products/sneakers/timberlands.png', filename: 'timberlands.png' }
].freeze

JACKETS_IMAGES = [
  { path: 'app/assets/images/products/jackets/black-shearling.png', filename: 'black-shearling.png' },
  { path: 'app/assets/images/products/jackets/blue-jean-jacket.png', filename: 'blue-jean-jacket.png' },
  { path: 'app/assets/images/products/jackets/grey-jean-jacket.png', filename: 'grey-jean-jacket.png' },
  { path: 'app/assets/images/products/jackets/brown-shearling.png', filename: 'brown-shearling.png' },
  { path: 'app/assets/images/products/jackets/brown-trench.png', filename: 'brown-trench.png' }
].freeze

WOMENS_IMAGES = [
  { path: 'app/assets/images/products/womens/blue-tank.png', filename: 'blue-tank.png' },
  { path: 'app/assets/images/products/womens/floral-blouse.png', filename: 'floral-blouse.png' },
  { path: 'app/assets/images/products/womens/floral-skirt.png', filename: 'floral-skirt.png' },
  { path: 'app/assets/images/products/womens/red-polka-dot-dress.png', filename: 'red-polka-dot-dress.png' },
  { path: 'app/assets/images/products/womens/striped-sweater.png', filename: 'striped-sweater.png' },
  { path: 'app/assets/images/products/womens/yellow-track-suit.png', filename: 'yellow-track-suit.png' },
  { path: 'app/assets/images/products/womens/white-vest.png', filename: 'white-vest.png' }
].freeze

MENS_IMAGES = [
  { path: 'app/assets/images/products/mens/camo-vest.png', filename: 'camo-vest.png' },
  { path: 'app/assets/images/products/mens/floral-shirt.png', filename: 'floral-shirt.png' },
  { path: 'app/assets/images/products/mens/long-sleeve.png', filename: 'long-sleeve.png' },
  { path: 'app/assets/images/products/mens/pink-shirt.png', filename: 'pink-shirt.png' },
  { path: 'app/assets/images/products/mens/roll-up-jean-shirt.png', filename: 'froll-up-jean-shirt.png' },
  { path: 'app/assets/images/products/mens/polka-dot-shirt.png', filename: 'polka-dot-shirt.png' }
].freeze

performance = Benchmark.measure do
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

  FactoryBot.create_list(:user, 100)

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

  def create_products(category, count)
    products = []

    count.times do
      title = Faker::Commerce.product_name
      price = Faker::Commerce.price(range: 0..1000)

      products << { title:, price:, category_id: category.id, created_at: Time.zone.now, updated_at: Time.zone.now }
    end

    Product.insert_all(products)
  end

  def attach_images_and_variants(category)
    category_images = case category.title
                      when 'hats'
                        HATS_IMAGES
                      when 'sneakers'
                        SNEAKERS_IMAGES
                      when 'jackets'
                        JACKETS_IMAGES
                      when 'womens'
                        WOMENS_IMAGES
                      when 'mens'
                        MENS_IMAGES
                      end

    Product.where(category:).each do |product|
      image = category_images.sample
      product.image.attach(io: Rails.root.join(image[:path]).open,
                           filename: image[:filename],
                           content_type: 'image/png')
      variants = []
      colors = random_items(PRODUCT_COLORS)
      colors.each do |color|
        sizes = random_items(PRODUCT_SIZES)
        sizes.each do |size|
          amount = rand(100)
          variants << { color:, size: size.to_s, amount:, product_id: product.id, created_at: Time.zone.now,
                        updated_at: Time.zone.now }
        end
      end

      Variant.insert_all(variants)
    end
  end

  create_products(hats, 3000)
  attach_images_and_variants(hats)
  create_products(sneakers, 4000)
  attach_images_and_variants(sneakers)
  create_products(jackets, 2000)
  attach_images_and_variants(jackets)
  create_products(womens, 3000)
  attach_images_and_variants(womens)
  create_products(mens, 3000)
  attach_images_and_variants(mens)

  Category.reindex
  Product.reindex
end

Rails.logger.debug { "Completed in #{performance.real} seconds" }
