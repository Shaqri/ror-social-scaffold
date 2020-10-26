require 'rails_helper'


RSpec.describe 'User features' do
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
    it 'Returns a list with all registered users' do
      sign_up
      visit('/users')
      expect(page).to have_content('Victor')
    end
  end

  describe 'Viewing show' do
    it 'display user profile' do
      sign_up
      click_link(User.first.name)
      expect(page).to have_content(User.first.name)
      expect(page).to have_content('Recent posts')
    end
  end
end
