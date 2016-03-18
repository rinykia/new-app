  class Administrators::MessagesController < AdministratorsController
  before_action :set_message, only: [:edit, :update, :destroy]

  def index
    @messages = Message.all.order(:id).reverse
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to administrators_messages_path(@message), notice: 'Новость добавлена.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to administrators_messages_path(@message), notice: 'Новость обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to administrators_messages_path(@message), notice: 'Новость удалена.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :article, :description, :picture)
    end
end
