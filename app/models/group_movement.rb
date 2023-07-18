# frozen_string_literal: true

# class GroupMovement budgetApp
class GroupMovement < ApplicationRecord
  belongs_to :group
  belongs_to :movement
end
