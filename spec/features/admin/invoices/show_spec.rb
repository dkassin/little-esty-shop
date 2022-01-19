require 'rails_helper'

RSpec.describe 'Admin Invoices Show' do
  describe 'view' do

    it 'I see information related to that invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end

    it 'I can update the invoice status' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("pending")
      select "in progress", from: "invoice_status"
      click_on "Update Invoice Status"

      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_1.status}")
    end

    it 'displays all of the items and their attributes' do
      visit "/admin/invoices/#{@invoice_5.id}"


      within "#invoice_show-#{@invoice_5.id}" do

        expect(page).to have_content("#{@invoice_5.invoice_items.first.item.name}")
        expect(page).to have_content("#{@invoice_5.invoice_items.first.quantity}")
        expect(page).to have_content("#{@invoice_5.invoice_items.first.unit_price}")
        expect(page).to have_content("#{@invoice_5.invoice_items.first.status}")
      end
    end

    it 'I see the total revenue and the total discounted revenue for an invoice with multiple merchants' do
      visit "/admin/invoices/#{@invoice_2.id}"

      within "#admin_revenue" do
        expect(page).to have_content("Total revenue generated: #{h.number_to_currency(@invoice_2.total_revenue/100, precision: 0)}")
        expect(page).to have_content("Total discount revenue generated: #{h.number_to_currency(@invoice_2.total_discount_rev/100, precision: 0)}")
      end

    end
  end
end
