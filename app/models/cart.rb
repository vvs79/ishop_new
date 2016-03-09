class Cart < ActiveRecord::Base
  has_one    :item
  belongs_to :order
  belongs_to :user
end
