class Message < ActiveRecord::Base
  validates :title, :article, :description, :picture, presence: true
  mount_uploader :picture,  InformationPictureUploader
end
