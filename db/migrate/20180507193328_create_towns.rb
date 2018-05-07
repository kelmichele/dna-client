class CreateTowns < ActiveRecord::Migration[5.2]
  def change
    create_table :towns do |t|
    	t.string :townname
	    t.string :state_name
    	t.timestamps
    end

    add_index :towns, :townname
  	add_index :towns, :id
  end
end
