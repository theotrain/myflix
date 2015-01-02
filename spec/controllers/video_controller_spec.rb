require 'spec_helper'

describe VideosController do


  describe "GET show" do  

    it "sets the @video variable with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirects to root_path with unauthenticated user" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end

  end

  describe "GET search" do

    it 'sets @videos for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video, title:'futurama')
      get :search, search: 'ama'
      expect(assigns(:videos)).to eq([video])
    end
    it 'redirects to root_path for unauthenticated users' do
      video = Fabricate(:video, title:'futurama')
      get :search, search: 'van'
      expect(response).to redirect_to root_path
    end
  end

  # describe "GET rate" do
  
  #   it 'sets rating and message body for authenticated users' do
  #   end
  #   it 'redirects unauthenticated users to root_path' do
  #   end
  #   it 'requires a message body' do
  #   end

  # end

end