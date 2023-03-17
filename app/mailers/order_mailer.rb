# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def product_out_of_stock_after_payment_email
    @user = params[:user]
    @variant = params[:variant]

    mail to: @user.email, subject: 'Product is out of stock | Crown Clothing'
  end

  def order_payment_received_email
    @user = params[:user]
    @order = params[:order]

    mail to: @user.email, subject: 'Order has been paid | Crown Clothing'
  end
end
