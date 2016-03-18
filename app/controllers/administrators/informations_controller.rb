class Administrators::InformationsController < AdministratorsController

  before_action :set_informarion, only: [:edit, :update, :destroy]

  def index
    @informations = Information.all
  end  

  def new
    @information = Information.new
  end

  def edit
  end

  def create
    @information = Information.new(information_params)

    respond_to do |format|
      if @information.save
        format.html { redirect_to administrators_information_path(@information), notice: 'Новость добавлена.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @information.update(information_params)
        format.html { redirect_to administrators_information_path(@information), notice: 'Новость обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @information.destroy
    respond_to do |format|
      format.html { redirect_to administrators_informations_path(@information), notice: 'Новость удалена' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_information
      @information = Information.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def information_params
      params.require(:information).permit(:title, :article, :description, :picture)
    end
end

