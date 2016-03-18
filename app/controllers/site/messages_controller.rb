class Site::MessagesController < SiteController
  before_action :set_menu, only: [:index, :show]
  def index
    @messages = Message.all.order(:id).reverse
  end


  def show
    @message = Message.find(params[:id])    
  end

  private

  def set_menu
    @menus = Menu.all
  end


end