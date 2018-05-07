class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
		add_column :users, :firstname, :string, null: false
		add_column :users, :lastname, :string, null: false
		add_index :users, :firstname
		add_index :users, :lastname
  end
end
