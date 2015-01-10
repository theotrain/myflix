class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_uniqueness_of :video_id, scope: :user_id

  def rating(current_user)
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

end