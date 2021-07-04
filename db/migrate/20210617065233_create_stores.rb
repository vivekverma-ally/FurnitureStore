class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
