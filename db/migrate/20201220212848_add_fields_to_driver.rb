class AddFieldsToDriver < ActiveRecord::Migration[6.1]
  def change
    add_column :drivers, :cities, :string, array: true
    add_column :drivers, :max_stops_accepted, :integer
  end
end
