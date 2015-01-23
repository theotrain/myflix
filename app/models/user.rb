class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, length: { minimum: 4 }
  validates :full_name, presence: true, length: { minimum: 3 }
  has_many :reviews
  has_many :queue_items, -> { order('display_order') }

  def normalize_queue_items_order
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(display_order: index + 1)
    end
  end
  
end