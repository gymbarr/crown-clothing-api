# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe '#product_out_of_stock_after_payment_email' do
    subject(:mail) do
      described_class.with(user:, variant:)
                     .product_out_of_stock_after_payment_email
                     .deliver_now
    end

    let(:user) { create(:user) }
    let(:variant) { create(:variant) }

    it 'increments mail deliveries counter by 1' do
      expect { mail }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1)
    end

    it 'renders the user email' do
      expect(mail.to[0]).to eq(user.email)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Product is out of stock | Crown Clothing')
    end

    it 'renders the body in html format' do
      expect(mail.html_part.body.encoded)
        .to match(/is out of stock/)
    end

    it 'renders the body in plain text format' do
      expect(mail.text_part.body.encoded)
        .to match(/is out of stock/)
    end
  end

  describe '#order_payment_received_email' do
    subject(:mail) do
      described_class.with(user:, order:)
                     .order_payment_received_email
                     .deliver_now
    end

    let(:user) { create(:user) }
    let(:order) { create(:order, user:) }

    it 'increments mail deliveries counter by 1' do
      expect { mail }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1)
    end

    it 'renders the user email' do
      expect(mail.to[0]).to eq(user.email)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Order has been paid | Crown Clothing')
    end

    it 'renders the body in html format' do
      expect(mail.html_part.body.encoded)
        .to match(/we have received the payment for your order/)
    end

    it 'renders the body in plain text format' do
      expect(mail.text_part.body.encoded)
        .to match(/we have received the payment for your order/)
    end
  end
end
