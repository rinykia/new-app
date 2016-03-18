class Album < ActiveRecord::Base
	has_many :photos
  validates :name, :cover, presence: true

	mount_uploader :cover, AlbumCoverUploader
end
