class Administrators::MenuItemsController < AdministratorsController
 before_action :set_menu_item, only: [:edit, :update, :destroy]
  def index
    @menu_items = MenuItem.all.reverse 
  end

  def new
    @menu_item = MenuItem.new
  end

  def edit
  end
  
  def create
    @menu_item = MenuItem.new(menu_item_params)
    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to new_administrators_menu_item_path, notice: 'Информация добавлена.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update    
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to administrators_menu_items_path(@menu_item), notice: 'Информация обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to administrators_menu_items_path(@menu_item), notice: 'Информация удалена.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:menu_id, :title, :description, :quantity, :price)
    end
end
