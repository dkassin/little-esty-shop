class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.create(bulk_discount_params)

    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def destroy
    discount = BulkDiscount.find(params[:id])
    discount.destroy

    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end

  private
    def bulk_discount_params
      params.permit(:name, :discount, :quantity_threshold, :discount_id)
    end
end
