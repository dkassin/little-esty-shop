require 'rails_helper'

RSpec.describe "Merchant Bulk Discount index" do
  it 'Shows a list of all bulk discounts and attributes' do
    visit merchant_bulk_discounts_path(@merchant_1)

    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_2.name)
    expect(page).to_not have_content(@discount_3.name)
  end

  it 'when the discount name link it clicked it goes to the discount show page' do
    visit merchant_bulk_discounts_path(@merchant_1)

    expect(page).to have_content(@discount_1.name)

    click_link("#{@discount_1.name}")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}")
  end

  it 'when the create new discount link it clicked it takes the user to a creation form' do
    visit merchant_bulk_discounts_path(@merchant_1)

    click_link("Create a new discount")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/new")
  end
end
