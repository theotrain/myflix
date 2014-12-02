require 'spec_helper'

 describe Category do
#   it 'saves itself' do
#     category = Category.new(name:'some kinda name')
#     category.save
#     expect(Category.first).to eq(category)
#   end

it { should have_many(:videos) }

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