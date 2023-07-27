require 'rails_helper'

RSpec.describe 'Show Post Details', type: :feature do
  before do
    @user = User.create(name: 'Thomas Heflord', photo: 'user_photo_url')
    @post = Post.create(user: @user, title: 'Morality',
                        text: 'Strive for Personal Growth: Embrace personal growth and strive to become the')
    Comment.create(author: @user, post: @post, text: 'Great lesson for everyone')
    visit user_post_path(user_id: @user.id, id: @post.id)
  end

  it 'displays the post details and comments' do
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.user.name)
    expect(page).to have_content(@post.text)
    expect(page).to have_content("Comments: #{@post.comments.count}")
    expect(page).to have_content("Likes: #{@post.likes.count}")

    within('.comment') do
      fill_in 'Enter your comment', with: 'New comment'
      click_button 'Add Comment'
    end

    within('.like') do
      click_button 'Like'
    end

    # Add assertions for newly created comment and like if required
  end
end
