# class User budgetApp
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :groups, foreign_key: :author_id, dependent: :destroy
  has_many :movements, foreign_key: :author_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def total_expenses
    movements.sum(:amount)
  end
end
