class VideosController < ApplicationController
  def index
    # @videos = Video.order(:title)
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

end