class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all.where(merchant_id: params[:merchant_id])
  
  end
end
