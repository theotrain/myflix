require 'spec_helper'

feature 'user interacts with the queue' do
  scenario 'user adds and reorders videos on the queue' do
    cat = Category.create(name: "comedy")
    video1 = Fabricate(:video, category: cat, small_cover_url:'monk1.jpg')
    video2 = Fabricate(:video, category: cat, small_cover_url:'monk2.jpg')
    video3 = Fabricate(:video, category: cat, small_cover_url:'monk3.jpg')

    sign_in
    find("a[href='/videos/#{video1.id}']").click
    expect(page).to have_content video1.description

    click_link('+ My Queue')
    page.should have_content 'List Order'

    click_link(video1.title)
    expect(page).to have_content video1.description
    page.should have_no_link '+ My Queue'

    find_link('Videos').click
    find("a[href='/videos/#{video2.id}']").click
    click_link('+ My Queue')
    find_link('Videos').click
    find("a[href='/videos/#{video3.id}']").click
    click_link('+ My Queue')

    fill_in("video_#{video1.id}", :with => 3)
    fill_in("video_#{video2.id}", :with => 1)
    fill_in("video_#{video3.id}", :with => 2)
    
    # find('#update').click
    # click_button("update")
    find("input[id='update_instant_queue']").click
    # find('#update_instant_queue').click
    # click_on 'Update Instant Queue'
    # save_and_open_page
  end
end

