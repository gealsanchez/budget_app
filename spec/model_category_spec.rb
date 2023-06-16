require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @user = User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
  end

  it 'is valid with correct parameters' do
    group = Group.create!(name: 'Gaming', icon: 'icon1.svg', author: @user)
    expect(group).to be_valid
  end

  it 'is invalid without an author' do
    group = Group.new(name: 'Gaming', icon: 'icon1.svg')
    expect(group).to_not be_valid
  end

  describe 'associations' do
    it 'should have many movements through group_movements' do
      group = Group.reflect_on_association(:movements)
      expect(group.macro).to eq(:has_many)
      expect(group.through_reflection.name).to eq(:group_movements)
    end

    it 'should have many group_movements' do
      group = Group.reflect_on_association(:group_movements)
      expect(group.macro).to eq(:has_many)
    end
  end
end
