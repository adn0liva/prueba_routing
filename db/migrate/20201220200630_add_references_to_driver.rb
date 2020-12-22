class AddReferencesToDriver < ActiveRecord::Migration[6.1]
  def change
    add_reference :drivers, :vehicle, null: true, foreign_key: true
  end
end
