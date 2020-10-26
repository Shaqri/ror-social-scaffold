require 'rails_helper'

RSpec.describe 'Post features' do
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
  describe 'Viewing index' do
    it 'display rencent posts' do
      sign_up
      visit('/')
      expect(page).to have_content('Recent posts')
    end
  end

  describe 'Creating a post' do
    it 'creates a post when valid' do
        sign_up
        visit('/')
        fill_in('post_content', with: 'First post')
        click_button('Save')
        expect(page).to have_content('Post was successfully created.')
        expect(Post.first.content).to eq('First post')
    end
  end
end
