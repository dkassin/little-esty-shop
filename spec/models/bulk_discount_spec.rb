require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of :discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of :quantity_threshold }
    it { should validate_numericality_of :discount }
  end

  describe 'relationships' do
    it { should belong_to(:merchant)}
    it { should have_many(:items) }

  end
end
