require 'spec_helper'

feature "Signing in" do

  # background do
  #   User.make(:email => 'user@example.com', :password => 'caplin')
  # end

  scenario "Signing in with valid username and password" do
    joe = Fabricate(:user)
    sign_in(joe)
    # visit sign_in_path
    # fill_in 'email', :with => joe.email
    # fill_in 'password', :with => joe.password
    # click_button 'Sign In'
    expect(page).to have_content joe.full_name
  end

  scenario "Signing in with invalid username and password" do
    visit sign_in_path
    fill_in 'email', :with => 'whatever@example.com'
    fill_in 'password', :with => 'assface'
    click_button 'Sign In'
    # save_and_open_page
    expect(page).to have_content 'something wrong'
  end
end