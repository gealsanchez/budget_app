require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/movements', type: :request do
  # rubocop:enable Metrics/BlockLength
  before do
    @user = User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
    sign_in @user
  end

  let(:valid_attributes) do
    {
      name: 'Gaming',
      amount: nil,
      author: @user
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      amount: nil,
      author: @user
    }
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_movement_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      movement = Movement.create! valid_attributes
      get edit_movement_url(movement)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new transaction' do
        expect do
          post movements_url, params: { movement: valid_attributes }
        end.to change(Movement, :count).by(1)
      end

      it 'redirects to the new transaction' do
        post movements_url, params: { movement: valid_attributes }
        expect(response).to redirect_to(movement_url(Movement.last))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'delete the transaction' do
      movement = Movement.create! valid_attributes
      expect do
        delete movement_url(movement)
      end.to change(Movement, :count).by(-1)
    end

    it 'redirects to the transactions list' do
      movement = Movement.create! valid_attributes
      delete movement_url(movement)
      expect(response).to redirect_to(movements_url)
    end
  end
end
