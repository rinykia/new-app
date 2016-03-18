class MenuItem < ActiveRecord::Base
	belongs_to :menu
  validates :title, :quantity, :price, presence: true
end
