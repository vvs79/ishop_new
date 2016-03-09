class Order < ActiveRecord::Base
  has_many :cart
end
