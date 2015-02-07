class Video < ActiveRecord::Base
  has_many :queue_items
  has_many :reviews, -> { order("created_at DESC") }
  belongs_to :category
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  scope :search_by_title, -> (search_term) { search_term.blank? ? [] : Video.where("lower(title) LIKE (?)", "%#{search_term.downcase}%") }

  def average_rating
    if self.reviews.size > 0
      self.reviews.average(:rating)
    else
      nil
    end
  end

  def rating_display
    if average_rating != nil
      "#{average_rating.round(1)}/5.0"
    else
      "No Ratings Yet"
    end
  end

  def inQueue?(current_user)
    QueueItem.where(user: current_user, video_id:id).count > 0
  end

end