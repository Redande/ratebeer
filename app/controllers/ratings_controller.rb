class RatingsController < ApplicationController
  before_action :skip_if_cached, only:[:index]

  def skip_if_cached
    return render :index if fragment_exist?( "ratings"  )
  end

  def index
    @ratings = Rating.includes(:brewery, :beer, :style, :user).all
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @most_raters = User.most_raters 3
    @recent = Rating.recent
    @top_styles = Style.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end
