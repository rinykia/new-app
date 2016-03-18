class Site::CommentsController < SiteController
  before_action :set_menu, only: [:index]
 def index
    @comments = Comment.all.reverse
    @comment = Comment.new(params[:comment])
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_url, notice: 'Сообщение отправлено.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:name, :email, :phone, :body)
  end

  def set_menu
    @menus = Menu.all
  end


end