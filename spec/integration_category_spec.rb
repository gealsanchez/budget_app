require 'rails_helper'
require 'faker'
require 'cancan'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Group#Index', type: :system do
  # rubocop:enable Metrics/BlockLength
  let(:user) do
    User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
  end

  let(:group) do
    Group.create(name: 'Gaming', icon: 'icon1.svg', author: user)
  end

  let(:movement) do
    Movement.create(name: 'Modern Warfare II', amount: 80, author: user)
  end

  let(:movement2) do
    Movement.create(name: 'FIFA 23', amount: 70.5, author: user)
  end

  before do
    sign_in user
  end

  describe 'index page' do
    it 'has the user Categories' do
      Group.create(name: 'Education', icon: 'icons.jpg', author: user)
      visit groups_path
      expect(page).to have_content('Education')
    end

    it 'has button to create a new category' do
      visit groups_path
      expect(page).to have_link('Add')
    end
  end

  describe 'Categories#Show' do
    it 'has the Add a new transaction button' do
      visit group_path(group.id)
      expect(page).to have_content('Add')
    end

    it 'has the Movement Modern Warfare' do
      GroupMovement.create(movement:, group:)
      visit group_path(group.id)
      expect(page).to have_content('Modern Warfare II')
      expect(page).to have_content('Total Movement U$ 80.0')
    end

    it 'has the total amount of the category' do
      GroupMovement.create(movement:, group:)
      GroupMovement.create(movement: movement2, group:)
      visit group_path(group.id)
      expect(page).to have_content('U$ 70.5')
    end

    it 'has the Back to categories button' do
      visit group_path(group.id)
      expect(page).to have_content('<')
    end
  end

  describe 'Category#New' do
    before do
      visit new_group_path
    end

    it 'has the input fields' do
      expect(page).to have_field('Name')
      expect(page).to have_css('.img_icon')
    end
  end

  describe 'Category#Create' do
    before do
      visit new_group_path
    end

    it 'creates a new category' do
      fill_in 'Name', with: 'Training'
      choose('group_icon_img_icon1')
      click_button 'Save'

      expect(page).to have_content('Successfully created.')
    end
  end

  describe 'Movememt create new' do
    before do
      visit movement_create_new_path(group.id)
    end

    it 'has the input fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Amount')
    end

    it 'Add new movement to category' do
      fill_in 'movement[name]', with: 'Call of Duty'
      fill_in 'movement[amount]', with: 89.5
      click_button 'Save'

      expect(page).to have_content('Successfully added')
    end
  end
end
