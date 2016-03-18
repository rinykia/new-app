class Administrators::AlbumsController < AdministratorsController

  before_action :set_album, only: [:edit, :update, :destroy]

  def index
    @albums = Album.all.reverse
  end

  def show
    @album = Album.find(params[:id])
    @menu_items = MenuItem.all
  end

  def edit
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
   # @album.assign_attributes(album_params)
    respond_to do |format|
      if @album.save
        format.html { redirect_to administrators_albums_path(@album), notice: 'Альбом создан.' }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to administrators_albums_path(@album), notice: 'Альбом обновлен.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Альбом удален.' }
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :cover)
  end

  def set_album
    @album = Album.find(params[:id])
  end

end