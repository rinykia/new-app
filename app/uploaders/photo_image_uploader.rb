class PhotoImageUploader < CarrierWave::Uploader::Base

 include CarrierWave::MiniMagick


  version :normal do
    process resize_to_fill: [100,100]
  end


end
