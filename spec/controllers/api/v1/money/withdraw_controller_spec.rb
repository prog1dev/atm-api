require 'spec_helper'

describe Api::V1::Money::WithdrawsController, type: :controller do
  describe 'PATCH #update' do
    before do
      { 50 => 4, 25 => 6, 10 => 3, 1 => 12 }.each do |k, v|
        Money.create!(count: v, value: k)
      end
    end

    context 'with valid params' do
      before {
        patch :update, params: { total: 200 }
      }

      it 'returns 200' do
        expect(response.status).to eq 200
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

