require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
    it { should have_many(:bulk_discounts).through(:merchant) }
    it { should have_one(:merchant).through(:item) }
  end

  it 'Show the best discount for an invoice_item' do
    expect(@invoice_item_2.best_discount).to eq(@discount_2)

    expect(@invoice_item_1.best_discount).to eq(nil)
  end

  it 'Show the best revenue for an invoice_item' do
    expect(@invoice_item_2.rev).to eq(1610)
  end

  it 'Show the discounted or regular revenue for an invoice_item' do
    expect(@invoice_item_2.discounted_rev).to eq(1127)
  end
end
