class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }
  validates :name, presence: true, uniqueness: true

  def recent_videos
    # return the 6 most recent videos sorted by created_at
    # self.videos.sort_by{|vid| vid.created_at }.reverse[0...6]
    videos.limit(6)
  end
end