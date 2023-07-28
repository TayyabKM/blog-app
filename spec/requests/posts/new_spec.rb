require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'New Post Form', type: :feature do
  before do
    # Create a user with the name "Thomas Heflord"
    @user = User.create(name: 'Thomas Heflord', photo: 'user_photo_url')

    # Update the URL to the correct path for creating a new post for the user
    visit new_user_post_path(@user)
  end

  it 'allows users to create a new post' do
    fill_in 'Post title', with: 'Test Post'
    fill_in 'Your post', with: 'This is a test post'
    click_button 'Save'

    expect(page).to have_content('Test Post')
    expect(page).to have_content('This is a test post')
    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
  end
end
