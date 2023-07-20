require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Placeholder text for all users')
    end
  end
  describe 'GET /show' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User', photo: 'test.jpg', bio: 'Test bio')
      get user_path(user)
      expect(response).to have_http_status(:success) # Test for the User#show action
    end
  end
end
