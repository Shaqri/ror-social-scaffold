require 'rails_helper'

RSpec.describe 'Comment features' do
  let(:sign_up) do
    visit('/')
    click_link('Sign up')
    within('form') do
      fill_in 'Name', with: 'Victor'
      fill_in 'Email', with: 'victor@victor.com'
      fill_in 'user_password', with: 'victor'
      fill_in 'user_password_confirmation', with: 'victor'
      click_button 'Sign up'
    end
  end
  let(:post) do
    Post.create(user_id: User.first.id, content: 'post content')
  end
  describe 'Creating a comment' do
    it 'comments a post' do
      sign_up
      post
      visit('/')
      fill_in('comment_content', with: 'my comment')
      expect(Post.first.comments.first).to eq(Comment.first)
    end
  end
end
