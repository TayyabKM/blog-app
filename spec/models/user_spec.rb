require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
  end

  describe 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('user_id')
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      user = described_class.new(name: nil, photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      expect(user.valid?).to be false
    end

    it 'validates presence of photo' do
      user = described_class.new(name: 'John Doe', photo: nil, bio: 'I am a teacher', posts_counter: 0)
      expect(user.valid?).to be false
    end

    it 'validates numericality of posts_counter' do
      user = described_class.new(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher',
                                 posts_counter: 'not a number')
      expect(user.valid?).to be false
      user.posts_counter = -1
      expect(user.valid?).to be false
    end

    it 'does not allow negative value for posts_counter' do
      user = described_class.new(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: -1)
      expect(user.valid?).to be false
    end
  end

  describe 'recent_posts' do
    let!(:post1) do
      Post.create(title: 'Post 1', text: 'body', author: @user, comments_counter: 0, likes_counter: 0)
    end
    let!(:post2) do
      Post.create(title: 'Post 2', text: 'body1', author: @user, comments_counter: 0, likes_counter: 0)
    end
    let!(:post3) do
      Post.create(title: 'Post 3', text: 'body2', author: @user, comments_counter: 0, likes_counter: 0)
    end
    let!(:post4) do
      Post.create(title: 'Post 4', text: 'body3', author: @user, comments_counter: 0, likes_counter: 0)
    end

    it 'should return last 3 posts' do
      expect(@user.recent_posts.count).to eq(3)
      expect(@user.recent_posts).to include(post2, post3, post4)
    end
  end
end
