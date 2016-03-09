class AddImagesToItems < ActiveRecord::Migration
  def change
    add_column :items, :images, :text
  end
end
