require 'spec_helper'

 describe Category do
#   it 'saves itself' do
#     category = Category.new(name:'some kinda name')
#     category.save
#     expect(Category.first).to eq(category)
#   end

it { should have_many(:videos) }


  describe '#recent_videos' do
    before :each do
      @blank_category = Category.create(name:'nothing')
      @category = Category.create(name:'TV Comedies')

      @monk = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: @category )
      @family_guy = Video.create(title: "Family Guy", description: "Eh mah gawd, its the greatest show of all times.  Suh fannah! fldlskjfl skfjlsdkjf lsdkfj kjkj kj !", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy_large.jpg", category: @category )
      @futurama = Video.create(title: "Futurama", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "futurama_large.jpg", category: @category )
      @south_park = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "south_park_large.jpg", category: @category )
      @monk2 = Video.create(title: "Monk2", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: @category )
      @family_guy2 = Video.create(title: "Family Guy2", description: "Eh mah gawd, its the greatest show of all times.  Suh fannah! fldlskjfl skfjlsdkjf lsdkfj kjkj kj !", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy_large.jpg", category: @category )
      @futurama2 = Video.create(title: "Futurama2", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "futurama_large.jpg", category: @category )
      @south_park2 = Video.create(title: "South Park2", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "south_park_large.jpg", category: @category )
 
    end

    it 'returns [] if there are no videos in the category' do
      expect(@blank_category.recent_videos).to eq([])
    end
    it 'returns 6 videos if there are more than six' do
      expect(@category.recent_videos.count).to eq(6)
    end
    it 'returns all the videos if there are less than six' do
      cat = Category.create(name:'junky')
      vid = Video.create(title: "Monk3", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: cat )
      # puts "CAT VIDEOS #{cat.videos}"
      expect(cat.recent_videos).to eq([vid])
    end

    it 'returns the most recent 6 videos' do
      # @category.videos.sort_by{ |v| v.created_at }.each {|vid| puts "#{vid.title} - CREATED AT#{vid.created_at.strftime('%Y-%m-%d %H:%M:%S.%N')}" }

      expect(@category.recent_videos).to eq([@south_park2, @futurama2, @family_guy2, @monk2, @south_park, @futurama])
    end



  end

  # it 'has many videos' do
  #   comedy = Category.create(name:'comedy')
  #   south_park = Video.create(title:'south park', description:'hi', category: comedy)
  #   futurama = Video.create(title:'futurizzle', description:'hi', category: comedy)
  #   # expect(Category.first.videos[0]).to eq(v1)
  #   # expect(Category.first.videos[1]).to eq(v2)
  #   # expect(Category.first.videos).to include(futurama, south_park)

  #   expect(comedy.videos).to eq([futurama, south_park])
  # end
 end

# test that a category can have many videos