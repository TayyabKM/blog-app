require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0, photo: 'photo.jpg') }
  let(:post) { Post.create(title: 'Test Post', text: 'Lorem ipsum', author: user, likes_counter: 0, comments_counter: 0) }
  let(:like) { Like.new(user: user, post: post) }

  describe 'associations' do
    it 'belongs to a user' do
      expect(like).to belong_to(:user).class_name('User').with_foreign_key('user_id')
    end

    it 'belongs to a post' do
      expect(like).to belong_to(:post).class_name('Post').with_foreign_key('post_id')
    end
  end

  describe '#update_likes_counter' do
    it 'updates the post\'s likes_counter' do
      expect { like.save }.to change { post.likes_counter }.by(1)
    end
  end
end
