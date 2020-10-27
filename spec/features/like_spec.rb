require 'rails_helper'

RSpec.describe 'Like features' do
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
  let(:create_post) do
    Post.create(user_id: User.first.id, content: 'post content')
    visit('/')
  end
  describe 'Creating a like' do
    it 'likes to a post' do
      sign_up
      create_post
      click_link('Like!')
      expect(page).to have_content('You liked a post.')
    end
  end

  describe 'Destroying a like' do
    it 'dislike a post' do
      sign_up
      create_post
      click_link('Like!')
      click_link('Dislike!')
      expect(page).to have_content('You disliked a post.')
    end
  end
end
