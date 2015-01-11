class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @my_queue = QueueItem.where(user: current_user).order("display_order ASC")
  end

  def create
    max_order = QueueItem.where(user: current_user).maximum(:display_order)
    max_order ? max_order+=1 : max_order=1
    QueueItem.create(user: current_user, video_id: params[:video_id], display_order: max_order)
    redirect_to my_queue_path
  end

  def destroy
    QueueItem.where(user: current_user, id: params[:id]).destroy_all
    redirect_to my_queue_path
  end

end