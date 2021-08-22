class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.integer :product_id
      t.integer	:cart_quantity
      t.timestamps
    end
  end
end
