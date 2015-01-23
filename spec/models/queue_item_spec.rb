require 'spec_helper'

describe QueueItem do
  it {should belong_to(:video)}
  it {should belong_to(:user)}
  it {should validate_numericality_of(:display_order).only_integer}
  describe '#rating' do

    it 'return the rating of the review when present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      expect(queue_item.rating).to eq(4)
    end
    it 'returns nil when no review present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#rating=' do
    it 'changes the rating of the review of the review is present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 3)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end

    it 'clears the rating of the review of the review is present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 1)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it 'creates a review with the rating if the review is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = QueueItem.create(user: user, video: video, display_order: 2)
      queue_item.rating = 2
      expect(Review.first.rating).to eq(2)
    end

  end
end