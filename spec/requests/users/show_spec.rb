require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'show', type: :feature, js: false do
  let(:user) { User.create(name: 'Thomas Heflord', photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=', bio: 'Hey there! I am a passionate man in my 30s who finds joy in hiking, working') }

  let!(:post) do
    Post.create(author_id: user.id, title: ' Morality',
                text: 'Strive for Personal Growth: Embrace personal growth and strive to become the best version')
  end

  let!(:post2) do
    Post.create(author_id: user.id, title: 'Honesty and Integrity',
                text: 'Practice integrity and honesty in your words and actions.')
  end

  let!(:post3) do
    Post.create(author_id: user.id, title: 'Consider Consequences:',
                text: 'Think about the potential consequences of your actions.')
  end

  let!(:post4) do
    Post.create(author_id: user.id, title: 'The Road Not Taken',
                text: 'Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler,')
  end

  before(:each) do
    visit user_path(user) # Assuming you have defined the `user_path` helper method
  end

  describe 'show page' do
    it 'shows the name and profile photo of the user' do
      expect(page).to have_css("img[src*='https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=']")
      expect(page).to have_content(user.name)
    end

    it 'displays the number of posts for a user' do
      expect(page).to have_content('4')
    end

    it 'displays the bio for a user' do
      expect(page).to have_content('Hey there! I am a passionate man in my 30s who finds joy in hiking, working')
    end

    it 'should have a button to see all posts' do
      expect(page).to have_link('See All Posts', href: user_posts_path(user))
    end
  end
end
