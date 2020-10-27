require 'rails_helper'

RSpec.describe 'Friendships features' do
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
  let(:create_friend) do
    User.create(email: 'example@example.com', name: 'sample', password: 'sample')
  end
  let(:create_friendship) do
    Friendship.new(user_id: User.first.id, friend_id: User.last.id, confirmed: false)
  end

  let(:send_friend_request) do
    sign_up
    create_friend
    click_link('All users')
    click_link('Add friend')
  end

  let(:login_as_friend) do
    visit('/')
    fill_in('user_email', with: 'example@example.com')
    fill_in('user_password', with: 'sample')
    click_button('Log in')
  end

  describe 'Viewing friendships' do
    it 'returns current user friend list' do
      sign_up
      create_friend
      create_friendship.confirmed = true
      create_friendship.save
      click_link('Friends')
      expect(page).to have_content('sample')
    end
    it 'returns current user friend requests' do
      sign_up
      create_friend
      create_friendship.user_id = User.last.id
      create_friendship.friend_id = User.first.id
      create_friendship.save
      click_link('Friends')
      expect(page).to have_content('Confirm friend request')
      expect(User.first.friend_requests.size).to eq(1)
    end
  end

  describe 'Creating friendships' do
    it 'creates a friend request' do
      send_friend_request
      expect(page).to have_content('Friend request sent')
      expect(User.first.pending_friends.first).to eq(User.last)
      expect(User.last.friend_requests.first).to eq(User.first)
    end
  end

  describe 'Update friendship' do
    it 'updates friendships confirm attribute if friend accepted' do
      send_friend_request
      click_link('Sign out')
      login_as_friend
      click_link('Friends')
      click_link('Confirm friend request')
      expect(page).to have_content('Friend request accepted')
      expect(User.first.friends.first).to eq(User.last)
    end
  end

  describe 'delete friend record' do
    it 'decline friend request' do
      send_friend_request
      click_link('Sign out')
      login_as_friend
      click_link('Friends')
      click_link('Decline')
      expect(page).to have_content('Friend request declined')
      expect(User.last.friend_requests).to eq([])
    end
    it 'cancels friend requests' do
      send_friend_request
      expect(User.first.pending_friends.first).to eq(User.last)
      click_link('Cancel Friend Request')
      expect(page).to have_content('Friend request canceled')
      expect(User.first.pending_friends).to eq([])
    end
    it 'delete a current friend' do
      sign_up
      create_friend
      create_friendship.confirmed = true
      create_friendship.save
      Friendship.create(user_id: User.last.id, friend_id: User.first.id, confirmed: true)
      click_link('Friends')
      click_link('Unfriend')
      expect(page).to have_content('Friend deleted')
      expect(User.first.friends).to eq([])
    end
  end
end
