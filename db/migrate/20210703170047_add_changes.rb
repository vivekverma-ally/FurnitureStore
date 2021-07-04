class AddChanges < ActiveRecord::Migration[6.1]
  def change
    add_column :cart, :status, :string 
  end
end
