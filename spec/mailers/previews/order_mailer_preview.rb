# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def product_out_of_stock_after_payment_email
    user = User.first
    variant = Variant.first

    OrderMailer.with(variant:,
                     user:)
               .product_out_of_stock_after_payment_email
  end
end
