class VideosController < ApplicationController
  before_action :require_user

  def index
    # @videos = Video.order(:title)
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    # binding.pry
    @videos = Video.search_by_title(params[:search])
  end
end