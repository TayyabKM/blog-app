require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0, photo: 'photo.jpg') }
  let(:post) { Post.create(title: 'Test Post', text: 'Lorem ipsum', author: user, likes_counter: 0, comments_counter: 0) }
  let(:comment) { Comment.new(text: 'Test comment', post: post, author: user) }

  describe 'associations' do
    it 'belongs to a post' do
      expect(comment).to belong_to(:post)
    end

    it 'belongs to an author' do
      expect(comment).to belong_to(:author).class_name('User')
    end
  end

  describe '#update_comments_counter' do
    it 'updates the post\'s comments_counter' do
      expect { comment.save }.to change { post.comments_counter }.by(1)
    end
  end

  describe 'validations' do
    it 'requires text to be present' do
      expect(comment).to validate_presence_of(:text)
    end
  end
end
