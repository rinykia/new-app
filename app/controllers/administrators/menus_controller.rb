class Administrators::MenusController < AdministratorsController
  before_action :set_menu, only: [:edit, :update, :destroy]

  def index
    @menus = Menu.all.reverse
  end

  def show 
    #@categories = Category.all
    @menu = Menu.find(params[:id])
    @menu_items = @menu.menu_items  
    
  end

  def new
    #@categories = Category.all
    @menu = Menu.new
  end

  def edit
    #@categories = Category.all
    @menu = Menu.find(params[:id])
    #redirect_to posts_path unless current_user == @post.user
  end

  def create
    @menu = Menu.new(menu_params)
    
    respond_to do |format|
      if @menu.save
        format.html { redirect_to administrators_menus_path(@menu), notice: 'Информация добавлена.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to administrators_menus_path(@menu), notice: 'Информация обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

 
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Запись удалена.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:article, :title, :quantity, :price, :image)
    end
end


