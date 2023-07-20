require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      get posts_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get posts_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get posts_path
      expect(response.body).to include('Placeholder text for all posts by a given user')
    end
  end
end
