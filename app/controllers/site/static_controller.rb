class Site::StaticController < SiteController
  before_action :set_menu, only: [:home]

  def home
   
  end

  private

  def set_menu
    @menus = Menu.all
  end


end