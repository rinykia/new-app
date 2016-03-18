class Photo < ActiveRecord::Base
	belongs_to :album
  validates :image, presence: true
	mount_uploader :image, AlbumCoverUploader
end
