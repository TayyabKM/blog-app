require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User Index', type: :feature, js: false do
  before do
    # Assuming you have already created some test users in your test database.
    # If not, you can create test users here using FactoryBot or other methods.
    visit users_path # Assuming you have a users index page at users_path.
  end

  describe 'User Index' do
    let!(:users) { User.all }

    it 'should display user name' do
      users.each { |user| expect(page).to have_content user.name }
    end

    it 'should display user photo' do
      users.each { |user| expect(page).to have_css("img[src='#{user.photo}']") }
    end

    it 'should display number of posts for each user' do
      users.each { |user| expect(page).to have_content("Number of posts: #{user.posts.count}") }
    end

    it 'should show user details when user profile picture is clicked' do
      user = User.first
      first("ul.users-list li.user a[href='/users/#{user.id}'] img[alt='User Photo'][width='100px']").click
      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end
  end
end
