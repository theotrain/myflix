require 'spec_helper'

describe Video do
  # it "saves itself" do
  #   vid = Video.new(title: "Menudo Dance Party", description: "This is terrible!")
  #   vid.save
  #   # expect(vid.title).to eq("Menudo Dance Party")
  #   # expect(Video.first.title).to eq("Menudo Dance Party")
  #   expect(Video.first).to eq(vid)
  # end

  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe 'search_by_title' do

    before(:each) do
      @video1 = Video.create(title:"Arthur", description:"its great")
      @video2 = Video.create(title:"Arthur's Castle", description:"its great")
      @video3 = Video.create(title:"Beloved Cas", description:"its great")
    end
    it 'returns an empty array if there are no results' do
      expect(Video.search_by_title("zxy")).to eq([])
    end
    it 'returns multiple movies' do
      expect(Video.search_by_title("Arthur")).to eq([@video1, @video2])
    end
    it 'returns any movie containing the search phrase' do
      expect(Video.search_by_title("cas")).to eq([@video2, @video3])
    end
    it 'returns an array of 1 movie if there is only 1' do
      expect(Video.search_by_title("Belo")).to eq([@video3])
    end
    it 'returns an empty array for search of empty string' do
      expect(Video.search_by_title("")).to eq([])
    end

  end
  # it "belongs to a category" do
  #   cat1 = Category.create(name:'category1')
  #   vid = Video.new(title: "Menudo", description: "terrible!")
  #   vid.category = cat1
  #   vid.save
  #   expect(Video.first.category).to eq(cat1)
  # end

  # it "does not save a video without a title" do
  #   video = Video.create(description:"there")
  #   video.should_not be_valid
  #   # expect(Video.count).to eq(0)
  # end

  # it "does not save a video withot a description" do
  #   video = Video.create(title:"hiya")
  #   video.should_not be_valid
  # end

end
