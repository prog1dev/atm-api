require 'spec_helper'

describe Api::V1::Money::RefillsController, type: :controller do
  describe 'POST #create' do
    before do
      available_values = [1, 2, 5, 10, 25, 50]

      available_values.each do |value|
        Money.create!(value: value, count: 0)
      end
    end

    context 'with valid params' do
      let(:refill_money) {
        { 50 => 4, 25 => 6, 10 => 3, 1 => 12 }
      }

      before do
        post :create, params: { money: refill_money }
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'refills atms money' do
        refill_money.each do |k, v|
          expect(Money.find_by!(value: k).count).to eq v
        end
      end
    end
  end
end
