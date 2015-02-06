require 'spec_helper'

describe QueueItem do
  it {should belong_to(:video)}
  it {should belong_to(:user)}
  describe '#rating' do

    it 'return the rating of the review when present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      expect(queue_item.rating(user)).to eq(4)
    end
    it 'returns nil when no review present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      expect(queue_item.rating(user)).to eq(nil)
    end
  end
end