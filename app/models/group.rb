# frozen_string_literal: true

# class Group budgetApp
class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :group_movements, dependent: :destroy
  has_many :movements, through: :group_movements

  def total_amount_group
    movements.sum(:amount)
  end
end
