require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = Post.reflect_on_association(:user)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('post_id')
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('post_id')
    end
  end

  describe 'validations' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
    end

    it 'should return false without title' do
      post = Post.create(text: 'This is lovely', author_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it 'should return false without text' do
      post = Post.create(title: 'This is lovely', author_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it 'validates likes_counter as a non-negative integer' do
      post = Post.new(title: 'My Post', text: 'Post body', author_id: @user.id, likes_counter: -1)
      expect(post).to be_invalid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates the maximum length of title' do
      post = Post.new(title: 'A' * 251, text: 'This is the post body', author_id: @user.id)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates comments_counter as a non-negative integer' do
      post = Post.new(title: 'My Post', text: 'Post body', author_id: @user.id, comments_counter: -1)
      expect(post).to be_invalid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'recent_comments' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      @post = Post.create(title: 'My post', text: 'Post body', author_id: @user.id, comments_counter: 0,
                          likes_counter: 0)
    end

    let!(:comment1) do
      Comment.create(text: 'Comment 1', author_id: @user.id, post: @post)
    end
    let!(:comment2) do
      Comment.create(text: 'Comment 2', author_id: @user.id, post: @post)
    end
    let!(:comment3) do
      Comment.create(text: 'Comment 3', author_id: @user.id, post: @post)
    end
    let!(:comment4) do
      Comment.create(text: 'Comment 4', author_id: @user.id, post: @post)
    end
    let!(:comment5) do
      Comment.create(text: 'Comment 5', author_id: @user.id, post: @post)
    end

    it 'should return last 3 comments' do
      expect(@post.recent_comments(3)).to eq([comment5, comment4, comment3])
    end
  end

  describe '#update_post_counter' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      @post = Post.create(title: 'My post', text: 'Post body', author_id: @user.id, comments_counter: 0,
                          likes_counter: 0)
    end

    it 'increments the author\'s posts_counter' do
      expect { @post.update_post_counter }.to change { @user.reload.posts_counter }.by(1)
    end
  end
end
