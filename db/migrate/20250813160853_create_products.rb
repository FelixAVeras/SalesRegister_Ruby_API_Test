class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 12, scale: 2, null: false, default: 0
      t.references :creator, null: false, foreign_key: { to_table: :admin_users }
      t.timestamps
    end
    add_index :products, :name
  end
end
