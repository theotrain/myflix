require 'spec_helper'

describe Video do

  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe 'search_by_title' do

    let!(:video1)  { Video.create(title:"Arthur", description:"its great") }
    let!(:video2)  { Video.create(title:"Arthur's Castle", description:"its great") }
    let!(:video3)  { Video.create(title:"Beloved Cas", description:"its great") }
    
    it 'returns an empty array if there are no results' do
      expect(Video.search_by_title("zxy")).to eq([])
    end
    it 'returns multiple movies' do
      expect(Video.search_by_title("Arthur")).to eq([video1, video2])
    end
    it 'returns any movie containing the search phrase' do
      expect(Video.search_by_title("cas")).to eq([video2, video3])
    end
    it 'returns an array of 1 movie if there is only 1' do
      expect(Video.search_by_title("Belo")).to eq([video3])
    end
    it 'returns an empty array for search of empty string' do
      expect(Video.search_by_title("")).to eq([])
    end

  end


end
