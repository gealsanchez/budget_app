# class CreateGroupMovements budgetApp
class CreateGroupMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :group_movements do |t|
      t.belongs_to :group, null: false, foreign_key: true
      t.belongs_to :movement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
