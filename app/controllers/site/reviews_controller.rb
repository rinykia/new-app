class Site::ReviewsController < SiteController
  before_action :set_menu, only: [:index, :show]
 def index
    @reviews = Review.all.reverse
    @review = Review.new(params[:review])
  end

  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_url, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  private

  def review_params
    params.require(:review).permit(:name, :email, :title, :body)
  end

  def set_menu
    @menus = Menu.all
  end


end