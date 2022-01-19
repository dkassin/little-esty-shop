require 'rails_helper'

RSpec.describe "Merchant Bulk Discount show" do
  it 'Shows a bulk discounts quantity threshold and percentage discount' do
    visit merchant_bulk_discount_path(@merchant_1, @discount_1)

    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.quantity_threshold)
    expect(page).to have_content(@discount_1.discount)
    expect(page).to_not have_content(@discount_2.name)
  end




end
