require 'spec_helper'

describe Api::V1::Bills::RefillsController, type: :controller do
  describe 'POST #create' do
    before do
      available_values = [1, 2, 5, 10, 25, 50]

      available_values.each do |value|
        Bill.create!(denomination: value, count: 0)
      end
    end

    context 'with valid params' do
      let(:refill_bills) {
        { 50 => 4, 25 => 6, 10 => 3, 1 => 12 }
      }

      before do
        post :create, params: { bills: refill_bills }
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'refills atm bills' do
        refill_bills.each do |k, v|
          expect(Bill.find_by!(denomination: k).count).to eq v
        end
      end
    end
  end
end
