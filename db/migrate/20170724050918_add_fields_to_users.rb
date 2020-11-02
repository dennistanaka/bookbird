class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :about, :text
    add_column :users, :profile_picture, :string
  end
end
