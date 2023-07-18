require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/groups', type: :request do
  # rubocop:enable Metrics/BlockLength
  before do
    @user = User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
    sign_in @user
  end

  let(:valid_attributes) do
    {
      name: 'Gaming',
      icon: 'icon1.svg',
      author: @user
    }
  end

  let(:invalid_attributes) do
    {
      name: 'Testing',
      icon: true,
      author: @user
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Group.create! valid_attributes
      get groups_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      group = Group.create! valid_attributes
      get group_url(group)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      group = Group.create! valid_attributes
      get edit_group_url(group)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post groups_url, params: { group: valid_attributes }
        end.to change(Group, :count).by(1)
      end

      it 'redirects to the new category' do
        post groups_url, params: { group: valid_attributes }
        expect(response).to redirect_to(group_url(Group.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post groups_url, params: { group: invalid_attributes }
        end.to change(Group, :count).by(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      group = Group.create! valid_attributes
      expect do
        delete group_url(group)
      end.to change(Group, :count).by(-1)
    end

    it 'redirects to the categories list' do
      group = Group.create! valid_attributes
      delete group_url(group)
      expect(response).to redirect_to(groups_url)
    end
  end
end
