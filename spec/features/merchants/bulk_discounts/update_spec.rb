require 'rails_helper'

RSpec.describe "Merchant Bulk Discount update" do
  it 'has a link to edit a bulk discount' do
    visit merchant_bulk_discount_path(@merchant_1, @discount_1)

    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.quantity_threshold)
    expect(page).to have_content(@discount_1.discount)

    click_link("Edit the bulk discount")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}/edit")

  end

  it 'updates the discount and redirects to the show page' do
      visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)

      fill_in(:name, with: "The Best Discount")
      fill_in(:quantity_threshold, with: 5)
      fill_in(:discount, with: 7.0)
      click_button "Submit"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @discount_1))
      expect(page).to have_content("The Best Discount")
      expect(page).to_not have_content("The Grand Discount")
      expect(page).to have_content(5)
      expect(page).to_not have_content(10)
      expect(page).to have_content(7.0)
      expect(page).to_not have_content(20.0)

  end
end
