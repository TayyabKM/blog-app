require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      get posts_path
      expect(response).to have_http_status(:success) # Changed the response expectation
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      post = FactoryBot.create(:post)
      expect(post).to be_valid
      get post_path(post.id)
      expect(response).to have_http_status(:success) # Test for the post#show action
    end
  end
end
