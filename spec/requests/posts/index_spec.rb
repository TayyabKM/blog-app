require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post index page', type: :request do
  it 'displays the posts and their details' do
    # Create a test user
    user = User.create(name: 'John Doe', photo: 'valid_photo_url')

    # Create some test posts associated with the user
    post1 = Post.create(user:, title: 'Post 1', text: 'Content of Post 1')
    post2 = Post.create(user:, title: 'Post 2', text: 'Content of Post 2')

    # Visit the index page for all posts associated with the user
    visit user_posts_path(user)

    # Now you can add your expectations based on the content you expect to see on the page
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)

    # Assert that the page contains the content of the posts
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
  end
end
