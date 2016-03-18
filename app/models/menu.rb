class Menu < ActiveRecord::Base
	has_many :menu_items
  validates :article, :title, :quantity, :price, :image, presence: true
  mount_uploader :image, MenuImageUploader
end
