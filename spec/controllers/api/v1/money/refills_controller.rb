require 'spec_helper'

describe Api::V1::Money::RefillsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      # let(:group) { create(:group_with_students) }

      before do
        # set_current_user(group.teacher)

        post :create
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end
    end
  end
end
