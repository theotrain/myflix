class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    # binding.pry
    @video = Video.find(params[:id])
    @reviews = @video.reviews

  end

  def search
    # binding.pry
    @videos = Video.search_by_title(params[:search])
  end

  def rate
    # binding.pry
    #rating, body, id

    # save rating
    @review = Review.new(user_id: current_user.id,  video_id: params[:id],  body: params[:body], rating: params[:rating])
    if @review.save
      flash[:notice] = "Your review was saved!"
      redirect_to video_path(params[:id])
    else
      @video = Video.find(params[:id])
      render :show
    end
    # @videos = Video.search_by_title(params[:search])
  end

end