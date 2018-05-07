class RemoveStateNameFromTowns < ActiveRecord::Migration[5.2]
  def change
  	remove_column :towns, :state_name, :string
  	add_column :towns, :state_id, :integer
  end
end
