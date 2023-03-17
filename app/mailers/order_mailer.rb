# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def product_out_of_stock_after_payment_email
    @variant = params[:variant]
    @user = params[:user]

    mail to: @user.email, subject: 'Product is out of stock | Crown Clothing'
  end
end
