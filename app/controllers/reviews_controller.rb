class ReviewsController < ApplicationController

  before_action :require_user

  def create
    # binding.pry
    @video = Video.find(params[:video_id])
    # Review.create(video: video, user: current_user, body: params[:review][:body], rating: params[:review][:rating])
    review = Review.new(video: @video, user: current_user, body: params[:review][:body], rating: params[:review][:rating])
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end
end