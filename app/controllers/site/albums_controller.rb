class Site::AlbumsController < SiteController
  before_action :set_menu, only: [:index, :show]
  def index
    @albums = Album.all
  end

  def show
  	@album = Album.find(params[:id])
  end

  private

  def set_menu
    @menus = Menu.all
  end

end