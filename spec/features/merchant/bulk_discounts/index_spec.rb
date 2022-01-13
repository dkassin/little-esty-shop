require 'rails_helper'

RSpec.describe "Merchant Bulk Discount index" do
  it 'Shows a list of all bulk discounts and attributes' do
    visit merchant_bulk_discounts_path(@merchant_1)

    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_2.name)
    expect(page).to_not have_content(@discount_3.name)
  end
end
