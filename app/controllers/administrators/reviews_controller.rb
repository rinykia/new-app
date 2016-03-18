class Administrators::ReviewsController < AdministratorsController
  before_action :set_review, only: [:destroy]

  def index
    @reviews = Review.all.reverse
    #@review = Review.new(params[:review])
  end 

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to administrators_reviews_path(@review), notice: 'Отзыв удален.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:name, :email, :title, :body)
    end
end
