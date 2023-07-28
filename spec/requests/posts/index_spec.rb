require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User profile page', type: :feature do
  before do
    @user = User.create(name: 'Thomas Heflord',
                        photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=',
                        posts_counter: 5)
    @posts = [
      Post.create(user: @user, title: 'Morality',
                  text: 'Strive for Personal Growth: Embrace personal growth and strive to become the best',
                  comments: []),
      Post.create(user: @user, title: 'Post 2 ',
                  text: 'Sample text',
                  comments: []),
      Post.create(user: @user, title: 'Post 3',
                  text: 'Practice integrity and honesty in your words and actions. Be true to your principles and',
                  comments: []),
      Post.create(user: @user, title: 'Post 4',
                  text: 'Sample text',
                  comments: []),
      Post.create(user: @user, title: 'Post 5',
                  text: 'Sample text',
                  comments: [])
    ]
  end
  it 'displays the user profile information and posts' do
    visit user_path(@user)

    expect(page).to have_content(@user.name)
    expect(page).to have_selector('img[src="https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4="]')
    expect(page).to have_content('Number of posts: 5')

    @user.posts.each do |post|
      expect(page).to have_selector('.post-container', text: post.text)
      within('.post-container', text: post.text) do
        expect(page).to have_content(post.text)
        expect(page).to have_content(post.text)
        expect(page).to have_content("Comments: #{post.comments.count}, Likes: #{post.likes.count}")

        post.comments.each do |comment|
          expect(page).to have_content("Username: #{comment.author.name}, Comment: #{comment.text}")
        end
      end
    end
  end

  it 'redirects to the post\'s show page when you click on a post' do
    # Visit the user's profile page
    visit user_path(@user)

    # Click on the first post link
    first('.post-container').click_link

    # Expect to be redirected to the post's show page
    expect(page).to have_current_path(user_post_path(@user, @posts.first))
  end
end
