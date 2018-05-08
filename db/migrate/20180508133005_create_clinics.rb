class CreateClinics < ActiveRecord::Migration[5.2]
  def change
    create_table :clinics do |t|
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

    add_index :clinics, :lab
    add_index :clinics, :addr1
    add_index :clinics, :city
    add_index :clinics, :state
    add_index :clinics, :zip
  end
end

