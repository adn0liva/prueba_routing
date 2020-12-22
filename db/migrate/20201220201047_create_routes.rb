class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.references :load_type, null: false, foreign_key: true
      t.float :load_sum, null: false
      t.string :cities, array: true
      t.integer :stops_amount, null: false
      t.references :vehicle, null: true, foreign_key: true
      t.references :driver, null: true, foreign_key: true
      t.timestamps
    end
  end
end
