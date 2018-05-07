class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
    	t.string :name
    	t.string :abv
    	t.timestamps
    end

  	add_index :states, :abv
  	add_index :states, :name
  end
end
