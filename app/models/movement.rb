# frozen_string_literal: true

# class Movement budgetApp
class Movement < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :group_movements, dependent: :destroy
  has_many :groups, through: :group_movements
end
