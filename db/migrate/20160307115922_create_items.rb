class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :name
      t.float    :price
    	t.text     :description
    	t.string   :kind
      t.boolean  :real, default: true
      t.integer  :user_id
    	t.integer  :quantity, default: 1
      t.timestamps null: false
    end
    add_index :items, :price
    add_index :items, :name
  end
end
