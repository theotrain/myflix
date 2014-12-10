class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  scope :search_by_title, -> (search_term) { search_term.blank? ? [] : Video.where("lower(title) LIKE (?)", "%#{search_term.downcase}%") }

end