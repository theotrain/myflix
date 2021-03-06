require 'spec_helper'

describe QueueItemsController do
  describe 'GET index' do
    context 'with authenticated users' do

      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context 'with queue_items entries' do
        it 'sets @my_queue with multiple items in order of display_order' do
          video = Fabricate(:video)
          review = Fabricate(:review, video: video, user: current_user)
          queue = QueueItem.create(user: current_user, video: video, display_order: 50)
          video2 = Fabricate(:video)
          review2 = Fabricate(:review, video: video2, user: current_user)
          queue2 = QueueItem.create(user: current_user, video: video2, display_order: 20)
          video3 = Fabricate(:video)
          review3 = Fabricate(:review, video: video3, user: current_user)
          queue3 = QueueItem.create(user: current_user, video: video3, display_order: 30)
          get :index
          expect(assigns(:my_queue)).to eq([queue2, queue3, queue])
        end
        it 'renders index template' do
          video = Fabricate(:video)  
          queue = QueueItem.create(user: current_user, video: video, display_order: 1)
          get :index
          expect(response).to render_template 'index'
        end

      end
      context 'without queue_items entries' do
        it 'returns empty @myqueue' do
          get :index
          expect(assigns(:my_queue)).to eq([])
        end
      end
    end
    context 'with unauthenticated users' do
      it 'redirects to root path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated users' do

      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      it 'adds a queue_items for the passed video' do
        video = Fabricate(:video)
        # queue = QueueItem.create(user: current_user, video: video, display_order: 10)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it 'adds a video w display_order +1 from the previous maximum' do
        video = Fabricate(:video)
        queue = QueueItem.create(user: current_user, video: video, display_order: 10)
        video2 = Fabricate(:video)
        post :create, video_id: video2.id
        expect(QueueItem.last.display_order).to eq(11)
      end
      it "does not add the video to the queue if its already up in there" do
        video = Fabricate(:video)
        queue = QueueItem.create(user: current_user, video: video, display_order: 10)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it 'redirects to queue_items#index' do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
    end
    context 'with un authentiocated users' do
      it 'redirects to the home page' do 
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with authenticated users' do

      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      it 'redirects to queue_items#index' do 
        video = Fabricate(:video)
        queue = QueueItem.create(user: current_user, video: video, display_order: 10)
        delete :destroy, id: queue.id
        expect(response).to redirect_to my_queue_path
      end
      it 'removes a queue item given a queue_item id' do
        video = Fabricate(:video)
        queue = QueueItem.create(user: current_user, video: video, display_order: 10)
        delete :destroy, id: queue.id
        expect(QueueItem.count).to eq(0)
      end
      it 'does not delete a queue item if the current user doesnt own it' do
        joe = Fabricate(:user)
        video = Fabricate(:video)
        queue = QueueItem.create(user: joe, video: video, display_order: 10)
        delete :destroy, id: queue.id
        expect(QueueItem.count).to eq(1)
      end
      it 'normalizes the remaining queue items' do
        queue_item1 = Fabricate(:queue_item, user: current_user, display_order: 2)
        queue_item2 = Fabricate(:queue_item, user: current_user, display_order: 5)
        queue_item3 = Fabricate(:queue_item, user: current_user, display_order: 10)
        delete :destroy, id: queue_item1.id
        expect(queue_item2.reload.display_order).to eq(1)
        expect(queue_item3.reload.display_order).to eq(2)
      end
    end

    context 'with unauthenticated users' do
      it 'redirects to root path' do 
        delete :destroy, id: 1
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST reorder' do
    context 'with valid inputs' do

      let(:current_user) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, display_order: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, display_order: 2) }
      before { session[:user_id] = current_user.id }

      it 'redirects to my queue page' do     
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 2}, {id: queue_item2.id, display_order: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it 'reorders queue items' do
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 2}, {id: queue_item2.id, display_order: 1}]
        expect(current_user.queue_items).to eq([queue_item2, queue_item1])
      end
      it 'normalizes queue item numbers to start at one' do 
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 3}, {id: queue_item2.id, display_order: 2}]
        expect(current_user.queue_items.map(&:display_order)).to eq([1,2])
      end
    end
    context 'with invalid inputs' do

      let(:current_user) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, display_order: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, display_order: 2) }
      before { session[:user_id] = current_user.id }

      it 'redirects to the my queue page' do 
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 3.4}, {id: queue_item2.id, display_order: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it 'sets the flash error message' do 
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 3.4}, {id: queue_item2.id, display_order: 1}]
        expect(flash[:error]).to be_present
      end
      it 'does not change the queue items' do 
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 2}, {id: queue_item2.id, display_order: 3.4}]
        expect(queue_item1.reload.display_order).to eq(1)
      end
    end
    context 'with unauthenticated user' do
      it 'redirects to root_path' do 
        post :reorder, queue_items: [{id: 1, display_order: 2}, {id: 2, display_order: 3}]
        expect(response).to redirect_to root_path
      end
    end
    context 'with queue items that dont belong to current user' do
      it 'should not change the queue items' do
        current_user = Fabricate(:user) 
        session[:user_id] = current_user.id 
        some_other_dude = Fabricate(:user) 
        queue_item1 = Fabricate(:queue_item, user: some_other_dude, display_order: 1)
        queue_item2 = Fabricate(:queue_item, user: some_other_dude, display_order: 2)
        post :reorder, queue_items: [{id: queue_item1.id, display_order: 2}, {id: queue_item2.id, display_order: 1}]
        expect(queue_item1.reload.display_order).to eq(1)
      end
    end
  end  

end