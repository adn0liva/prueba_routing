class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.float :capacity
      t.references :load_type, null: false, foreign_key: true
      t.references :driver, null: true, foreign_key: true
      t.timestamps
    end
  end
end
