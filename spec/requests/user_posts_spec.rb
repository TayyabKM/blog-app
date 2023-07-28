require 'rails_helper'

RSpec.describe 'UserPosts', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      user = User.create(name: 'Thomas Heflord',
                         photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=',
                         bio: 'Hey there! I am a passionate man in my 30s who finds joy in hiking, working')
      post = Post.create(author_id: user.id, title: 'Morality',
                         text: 'Strive for Personal Growth: Embrace growth and strive to become the best version')

      get user_post_path(user, post) # Use the nested route helper
      expect(response).to have_http_status(:success)
    end
  end
end
