require 'spec_helper'

describe Api::V1::BillsController, type: :controller do
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

      it 'returns 201' do
        expect(response.status).to eq 201
      end

      it 'refills atm bills' do
        refill_bills.each do |k, v|
          expect(Bill.find_by!(denomination: k).count).to eq v
        end
      end
    end
  end

  describe 'PATCH #update' do
    before do
      { 50 => 4, 25 => 6, 10 => 3, 1 => 12 }.each do |k, v|
        Bill.create!(denomination: k, count: v)
      end
    end

    context 'with valid params' do
      before {
        patch :update, params: { total: 200 }
      }

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns correct body response' do
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to eq({ "bills" => { "50" => 4 } })
      end
    end

    context 'with total more than available in atm' do
      before {
        patch :update, params: { total: 800 }
      }

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'returns correct error message' do
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response.fetch(:error)).to eq 'Not enough bills available'
      end
    end
  end
end
