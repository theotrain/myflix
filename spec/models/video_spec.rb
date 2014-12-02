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
