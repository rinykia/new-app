class Administrators::CommentsController < AdministratorsController
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.all.reverse
    #@review = Review.new(params[:review])
  end 

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to administrators_comments_path(@comment), notice: 'Сообщение удалено.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :email, :phone, :body)
    end
end
