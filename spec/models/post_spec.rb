require 'rails_helper'

RSpec.describe Post do
  let(:user) do
    User.create(email: 'victor@victor.com', name: 'victor', password: 'victor')
  end
  let(:post) do
    user
    described_class.create(user_id: user.id, content: '')
  end
  describe 'Associations' do
    it 'belongs to user' do
      post = described_class.reflect_on_association(:user)
      expect(post.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      comment = described_class.reflect_on_association(:comments)
      expect(comment.macro).to eq(:has_many)
    end

    it 'has many likes' do
      like = described_class.reflect_on_association(:likes)
      expect(like.macro).to eq(:has_many)
    end
  end

  describe '.ordered_by_most_recent' do
    it 'Returns post ordered by most recent' do
      expect(Post.all.ordered_by_most_recent.to_sql).to eq described_class.all.order(created_at: :desc).to_sql
    end
  end

  describe 'Validations' do
    describe 'content' do
      it 'must be present' do
        expect(post.errors[:content]).to eq(["can't be blank"])
      end
      it "can't exceed 1000 characters" do
        content = (1..500).to_a.join
        post.content = content
        post.valid?
        expect(post.errors[:content]).to eq(['1000 characters in post is the maximum allowed.'])
      end
    end
  end
end
