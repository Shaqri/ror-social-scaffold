require 'rails_helper'

RSpec.describe Friendship do
  describe 'associations' do
    it 'belongs to friend' do
      friendship = Friendship.reflect_on_association(:friend)
      expect(friendship.macro).to eq(:belongs_to)
    end
    it 'belongs to user' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eq(:belongs_to)
    end
  end
end
