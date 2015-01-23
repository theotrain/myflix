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
    current_user.normalize_queue_items_order
    redirect_to my_queue_path
  end

  def reorder
    begin
      update_queue_items
      current_user.normalize_queue_items_order
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "invalid order entry"
    end
    redirect_to my_queue_path
  end

  private

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update_attributes!(display_order: queue_item_data[:display_order], rating: queue_item_data[:rating]) if queue_item.user == current_user   
      end
    end
  end

end