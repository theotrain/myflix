require 'spec_helper'

feature 'add to my queue 3x and reorder my queue' do
  

  # background do
  #   # joe = Fabricate(:user)
  #   # video1 = Fabricate(:video, small_cover_url:'monk.jpg')
  #   # video2 = Fabricate(:video, small_cover_url:'monk.jpg')
  #   # video3 = Fabricate(:video, small_cover_url:'monk.jpg')
  #   # given(:other_user) { User.make(:email => 'other@example.com', :password => 'rous') }
  #   # given(:joe) {Fabricate(:user)}
  #   # given(:video1) {Fabricate(:video, small_cover_url:'monk.jpg')}
  #   # given(:video2) {Fabricate(:video, small_cover_url:'monk.jpg')}
  #   # given(:video3) {Fabricate(:video, small_cover_url:'monk.jpg')}
  # end

  # given(:joe) {Fabricate(:user)}
  # given(:video1) {Fabricate(:video, small_cover_url:'monk.jpg')}
  # given(:video2) {Fabricate(:video, small_cover_url:'monk.jpg')}
  # given(:video3) {Fabricate(:video, small_cover_url:'monk.jpg')}
  scenario 'dio it noooow' do
    joe = Fabricate(:user)
    cat = Category.create(name: "comedy")
    video1 = Fabricate(:video, category: cat, small_cover_url:'monk.jpg')
    video2 = Fabricate(:video, category: cat, small_cover_url:'monk.jpg')
    video3 = Fabricate(:video, category: cat, small_cover_url:'monk.jpg')
    # 1 - sign in 
    visit sign_in_path
    fill_in 'email', :with => joe.email
    fill_in 'password', :with => joe.password
    click_button 'Sign In'
    expect(page).to have_content joe.full_name
    # 2- go to a video
    # save_and_open_page
    find('.vid_id_'+video1.id.to_s).click
    expect(page).to have_content video1.description
    # 3 - add to my queue
    find('#my_queue').click
    # save_and_open_page
    expect(page).to have_content 'List Order'
    # 4 - click video link, insure we go to right video page
    find_link(video1.title).click
    # expect(page).to have_content video1.description
    # 5 - insure "+add to my queue" button is no longer on video page
    expect(page).to have_no_link('+ My Queue')
    # 6 - add 2 more videos to my queue
    
    # save_and_open_page
    # -----------------Add video 2 to my queue
    find_link('Videos').click
    find('.vid_id_'+video2.id.to_s).click
    find('#my_queue').click
    # -----------------Add video 3 to my queue
    find_link('Videos').click
    find('.vid_id_'+video3.id.to_s).click
    find('#my_queue').click
    # save_and_open_page
    # 7 - reorder them on my queue page
    fill_in('First Name', :with => 'John')
    click_button('Update Instant Queue')
    save_and_open_page

  end

  

  # 6 - add 2 more videos to my queue
  # 7 - reorder them on my queue page
  # 8 - update page
  # 9 - insure order has changed
  # videos_path

end