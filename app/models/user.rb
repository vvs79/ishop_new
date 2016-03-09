class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :login, presence: true, length: { maximum: 50 }

  has_many :items
  has_many :carts
  # has_one  :cart
  # has_many :orders
  # has_many :comments
end
