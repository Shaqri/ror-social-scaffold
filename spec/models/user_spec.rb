require 'rails_helper'

RSpec.describe User do

  let(:user) do
      user = User.new(email: 'victor@victor.com', name: '', password: 'victor' )
  end

  let(:create_users) do
    User.create(email: 'victor@victor.com', name: 'victor', password: 'victor')

    User.create(email: 'ana@ana.com', name: 'ana', password: 'anavela')
  end

  let(:_friendship) do
    Friendship.create(user_id: User.first.id, friend_id: User.last.id, confirmed: true )
  end

  describe 'Associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has_many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many pending friends' do
      user = User.reflect_on_association(:pending_friendships)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many friendship requests' do
      user = User.reflect_on_association(:friendship_requests)
      expect(user.macro).to eq(:has_many)
    end

  end

  describe 'Validations' do
    describe 'name' do
      it 'has to be present' do
        user.valid?
        expect(user.errors[:name]).to eq(["can't be blank"])
      end

      it 'has a maximum length of 20 characters' do
        user.name = 'victor manuel gonzalez buitrago'
        user.valid?
        expect(user.errors[:name]).to eq(["is too long (maximum is 20 characters)"])
      end

      it 'is valid' do
        user.name = 'victor'
        expect(user.valid?).to be true
      end
    end
  end

  describe '#friends' do
    it 'returns user friends list' do
      create_users
      _friendship
      expect(User.first.friends.first).to eq(User.last)
    end
  end

  describe '#pending_friends' do
    it 'returns a list filled out with pending friends' do
      create_users
      _friendship.confirmed = false
      _friendship.save
      expect(User.first.pending_friends.first).to eq(User.last)
    end
  end

  describe '#friend_requests' do
    it 'Returns a list filled out with friend requests' do
      create_users
      _friendship.confirmed = false
      _friendship.save
      expect(User.last.friend_requests.first).to eq(User.first)
    end
  end

  describe '#friend?' do
    it 'returns  true if given user is included in user friend list' do
      create_users
      _friendship
      expect(User.first.friend?(User.last)).to be true
    end

    it 'returns false if given user is not included in user friend list' do
      create_users
      expect(User.first.friend?(User.last)).to be false
    end
  end
end
