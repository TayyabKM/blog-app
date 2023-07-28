require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /index' do
    it 'returns a successful response' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success) # Changed the response expectation
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      post = FactoryBot.create(:post)
      expect(post).to be_valid
      get user_post_path(user_id: post.author_id, id: post.id)
      expect(response).to have_http_status(:success) # Test for the post#show action
    end
  end
end
