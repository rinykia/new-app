class Site::MenusController < SiteController

  def index
    @menus = Menu.all.includes(:menu_items)
  end


  def show 
    @menus = Menu.all
    @menu = Menu.find(params[:id])
    @menu_items = @menu.menu_items
  end

  private

  def set_menu
    @menus = Menu.all
  end


end