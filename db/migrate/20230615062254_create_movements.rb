# class CreateMovements budgetApp
class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end
