require 'rails_helper'

RSpec.describe "Merchant Bulk Discount new" do
  it 'show a form where a user can create a new item' do
    visit merchant_bulk_discounts_path(@merchant_1)
    expect(page).to_not have_content("The Jolly Discount")

    click_link("Create a new discount")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/new")

    fill_in('Name', with: 'The Jolly Discount')
    fill_in('Discount Percentage', with: 30)
    fill_in('Quantity Threshold', with: 14)
    click_button('Submit')

    new_discount = BulkDiscount.last

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts")
    
    expect(page).to have_content(new_discount.name)
  end
end
