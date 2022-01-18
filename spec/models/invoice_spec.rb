require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchant).through(:items) }
  end

  it '#total_revenue' do
    expect(@invoice_1.total_revenue).to eq(16)
    expect(@invoice_4.total_revenue).to eq(124800)
  end

  describe 'models' do
    it '#incomplete_invoices' do
      expected_result = [@invoice_1, @invoice_2, @invoice_3,
                         @invoice_4, @invoice_5, @invoice_6,
                         @invoice_7, @invoice_8, @invoice_9,
                         @invoice_10, @invoice_11, @invoice_12,
                         @invoice_13, @invoice_14, @invoice_15,
                         @invoice_19, @invoice_20]

      #Expected result ordered oldest to newest

      expect(Invoice.incomplete_invoices).to eq(expected_result)
    end

    it 'shows the discounted rev' do
      expect(@invoice_2.discount_rev_by_merchant(@merchant_1)).to eq(1127)
    end

    it 'shows only invoice items of desired merchant' do
      expect(@invoice_2.merchant_filter(@merchant_1).first).to eq(@invoice_item_2)
    end

    it ' discount' do
      expect(@invoice_1.method_test(@merchant_1)).to eq(0)
      expect(@invoice_2.method_test(@merchant_1)).to eq(1127)
    end

  end
end
