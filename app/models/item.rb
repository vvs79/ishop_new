class Item < ActiveRecord::Base
	validates :name, :price, :description, presence: true
  validates :name, length: { maximum: 80 }
  validates :description, length: { maximum: 10000 }
  validates :price, numericality: { greater_than: 0, allow_nil: true}
  
  belongs_to :user
  belongs_to :cart
  # has_many   :carts, through: :positions
  # has_many   :positions
  # has_many   :comments, as: :commantable
  # has_and_belongs_to_many :orders
  
  mount_uploaders :images, ImageUploader
  serialize :images, Array
end
