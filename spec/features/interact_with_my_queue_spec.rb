require 'spec_helper'

feature 'user interacts with the queue' do
  scenario 'user adds and reorders videos on the queue' do
    cat = Category.create(name: "comedy")
    video1 = Fabricate(:video, title: 'vid1', category: cat, small_cover_url:'monk1.jpg')
    video2 = Fabricate(:video, title: 'vid2', category: cat, small_cover_url:'monk2.jpg')
    video3 = Fabricate(:video, title: 'vid3', category: cat, small_cover_url:'monk3.jpg')

    sign_in
    add_video_to_queue(video1)
    page.should have_content 'List Order'

    click_link(video1.title)
    expect(page).to have_content video1.description
    page.should have_no_link '+ My Queue'

    add_video_to_queue(video2)
    add_video_to_queue(video3)

    find("input[data-video-id='#{video1.id}']").set(3)
    find("input[data-video-id='#{video2.id}']").set(1)
    find("input[data-video-id='#{video3.id}']").set(2)
    
    click_on 'Update Instant Queue'
    expect(find("input[data-video-id='#{video1.id}']").value).to eq('3')
    expect(find("input[data-video-id='#{video2.id}']").value).to eq('1')
    expect(find("input[data-video-id='#{video3.id}']").value).to eq('2')

  end

  def add_video_to_queue(video)
    find_link('Videos').click
    find("a[href='/videos/#{video.id}']").click
    click_link('+ My Queue')
  end

end

