require 'rails_helper'

RSpec.describe "Merchant Bulk Discount update" do
  it 'has a link to edit a bulk discount' do
    visit merchant_bulk_discount_path(@merchant_1, @discount_1)

    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.quantity_threshold)
    expect(page).to have_content(@discount_1.discount)

    click_link("Edit the bulk discount")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/edit")

  end
end
