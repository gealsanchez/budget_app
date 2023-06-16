require 'rails_helper'

RSpec.describe GroupMovement, type: :model do
  before do
    @user = User.create!(name: 'Eddie', email: Faker::Internet.email, password: 'P4ssw0rd')
    @movement = Movement.create!(name: 'Call of Duty', amount: 79.99, author: @user)
    @group = Group.create!(name: 'Gaming', icon: 'icon1.jpg', author: @user)
  end
  it 'is valid with correct parameters' do
    group_movements = GroupMovement.create!(group: @group, movement: @movement)
    expect(group_movements).to be_valid
  end

  it 'is invalid without a group' do
    group_movements = GroupMovement.new(movement: @movement)
    expect(group_movements).to_not be_valid
  end
end
