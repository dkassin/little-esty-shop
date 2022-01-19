require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  it '#total_revenue' do
    expect(@invoice_1.total_revenue).to eq(25)
    expect(@invoice_4.total_revenue).to eq(124815)
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

    it 'shows only invoice items of desired merchant even if invoice has two merchants' do
      expect(@invoice_2.merchant_filter(@merchant_1).first).to eq(@invoice_item_2)
    end

    it 'shows the total rev by a merchant on an invoice without discounts' do
      expect(@invoice_1.total_rev_by_merchant(@merchant_1)).to eq(25)
    end

    it 'shows the total rev by a merchant on an invoice without discounts even if invoice has two merchants' do
      expect(@invoice_2.total_rev_by_merchant(@merchant_1)).to eq(1610)
    end

    it ' shows discounted amount of revenue of an invoice that has one with discounts and one without' do
      expect(@invoice_1.amount_discount_rev_filtered(@merchant_1)).to eq(0)
    end

    it 'show the amount discounted from total revenue for an invoice with two merchants' do
      expect(@invoice_2.amount_discount_rev_filtered(@merchant_1)).to eq(483)
    end

    it 'shows two items on an invoice that are below a threshold but combined would be over the threshold, it applies no discount' do
      expect(@invoice_1.amount_discount_rev_filtered(@merchant_1)).to eq(0)
    end

    it 'shows an invoice has two items, one qualifies for a discount and another should not be discounted' do
      expect(@invoice_3.amount_discount_rev_filtered(@merchant_1)).to eq(3)
    end

    it 'shows an invoice has two items, both qualify for different discounts that are both applied seperately' do
      expect(@invoice_4.amount_discount_rev_filtered(@merchant_1)).to eq(37443)
    end

    it 'shows the total discounted revenue' do
      expect(@invoice_4.total_discounted_rev_filtered(@merchant_1)).to eq(87372)
    end

    it 'shows the amount discounted regardless of merchant on an invoice' do

      expect(@invoice_2.merchants.count).to eq(2)
      expect(@invoice_2.amount_discount_rev).to eq(4573.5)
    end

    it 'shows the total discounted revenue regardless of merchant on an invoice' do

      expect(@invoice_2.merchants.count).to eq(2)
      expect(@invoice_2.total_discount_rev).to eq(24306.5)
    end
  end
end
