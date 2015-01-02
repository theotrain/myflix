class Review < ActiveRecord::Base 
  belongs_to :user
  belongs_to :video
  # validates :body, presence: true
  validates_presence_of :body, :rating
end