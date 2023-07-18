require 'rails_helper'

RSpec.describe Movement, type: :model do
  before do
    @user = User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
  end

  it 'is valid with correct parameters' do
    movement = Movement.create!(name: 'Call of Duty', amount: 79.95, author: @user)
    expect(movement).to be_valid
  end

  it 'is invalid without an author' do
    movement = Movement.new(name: 'Modern Warfare', amount: 88.99)
    expect(movement).to_not be_valid
  end

  describe 'associations' do
    it 'should have many groups through group_movements' do
      movement = Movement.reflect_on_association(:groups)
      expect(movement.macro).to eq(:has_many)
      expect(movement.through_reflection.name).to eq(:group_movements)
    end

    it 'should have many group_movements' do
      movement = Movement.reflect_on_association(:group_movements)
      expect(movement.macro).to eq(:has_many)
    end
  end
end
