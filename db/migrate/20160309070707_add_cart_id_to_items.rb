class AddCartIdToItems < ActiveRecord::Migration

  def up
    add_column :items, :cart_id, :integer

    drop_table :carts_items
  end

end
