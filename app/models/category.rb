class Category < ActiveRecord::Base
  has_many :videos, -> { order("title") }
  validates :name, presence: true, uniqueness: true

  def recent_videos
    # return the 6 most recent videos sorted by created_at
    self.videos.sort_by{|vid| vid.created_at }.reverse[0...6]
  end
end