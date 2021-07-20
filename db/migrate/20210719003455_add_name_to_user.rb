class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :designation, :string
    add_column :users, :company, :string
    add_column :users, :address, :string

  end
end
