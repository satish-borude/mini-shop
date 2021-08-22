class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.integer :user_id
    	t.float :order_total
    	t.string  :order_status
    	t.string  :placed_on
      t.timestamps
    end
  end
end
