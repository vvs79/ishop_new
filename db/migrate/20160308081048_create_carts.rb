class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer  :item_id
      t.integer  :user_id
      t.integer  :order_id
      t.integer  :item_id
      t.integer  :quantity
      t.timestamps null: false
    end
  end
end
