class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
    	t.string :lab
    	t.string :detail
    	t.string :addr1
    	t.string :addr2
    	t.string :city
    	t.string :state
    	t.string :zip
    	t.string :phone
    	t.string :ext
    	t.string :fax
    	t.float :latitude
    	t.float :longitude
    	t.timestamps
    end

    add_index :locations, :lab
    add_index :locations, :addr1
    add_index :locations, :city
    add_index :locations, :state
    add_index :locations, :zip
  end
end
