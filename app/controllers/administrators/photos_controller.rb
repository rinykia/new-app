class Administrators::PhotosController < AdministratorsController
  #before_action :set_album, only: [:create, :edit, :update, :destroy]
  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.all.reverse
  end

  def edit
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
   # @photo.assign_attributes(photo_params)
    respond_to do |format|
      if @photo.save
        format.html { redirect_to new_administrators_photo_path(@photo), notice: 'Фото добавлено.' }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to administrators_photos_path(@photo), notice: 'Фото обновлено.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Фото удалено.' }
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :image, :album_id)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
  #def set_album
    #@album = Album.find(params[:album_id])
  #end

end