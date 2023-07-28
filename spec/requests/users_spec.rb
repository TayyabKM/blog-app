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
      user = FactoryBot.create(:user, photo: 'https://fastly.picsum.photos/id/480/200/300.jpg?hmac=-NCJbhpqFCFd17uR0DXt17Ccp5H073pZLLaStM6erZg')

      get user_path(user)

      expect(response).to have_http_status(:ok)

      # Use Capybara to parse the response body and check for the image tag
      expect(Capybara.string(response.body)).to have_selector("img[src='#{user.photo}'][alt='Profile picture']")
    end
  end
end
