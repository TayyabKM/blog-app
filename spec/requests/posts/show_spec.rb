RSpec.describe 'Show Post Details', type: :feature do
  before do
    @user = User.create(name: 'Thomas Heflord', photo: 'https://fastly.picsum.photos/id/480/200/300.jpg?hmac=-NCJbhpqFCFd17uR0DXt17Ccp5H073pZLLaStM6erZg')
    @post = Post.create(user: @user, title: 'Morality',
                        text: 'Strive for Personal Growth: Embrace personal growth and strive to become the')
    @comment = Comment.create(author: @user, post: @post, text: 'Great lesson for everyone')
    visit user_post_path(user_id: @user.id, id: @post.id)

    # Additional test setup to simulate comments by other users
    @other_user = User.create(name: 'Other User', photo: 'user_photo_url')
    @other_comment = Comment.create(author: @other_user, post: @post, text: 'Another comment')
    visit user_post_path(user_id: @user.id, id: @post.id)
  end

  it 'displays the post details and comments' do
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.user.name)

    within('.post-text') do
      expect(page).to have_content(@post.text)
    end

    within('.comments-list') do
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@other_comment.text) # Check for the other comment text
      expect(page).to have_content(@other_user.name) # Check that the other commenter's username is displayed
    end

    expect(page).to have_content('Comments: 2') # Check the total number of comments (2 comments now)
    expect(page).to have_content('Likes: 0') # Assuming no likes were created in the test setup
  end

  it 'displays the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'displays the username of each commentor' do
    within('.comments-list') do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@other_user.name)
    end
  end

  it 'displays the comment each commentor left' do
    within('.comments-list') do
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@other_comment.text)
    end
  end
end
