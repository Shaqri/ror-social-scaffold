require 'rails_helper'


RSpec.describe Comment do

  let(:user) do
    User.create(email: 'victor@victor.com', name: 'victor', password: 'victor')

  end

  let(:post) do
    Post.create(user_id: user.id, content: 'post content')

  end

  let(:comment) do
    Comment.create(user_id: user.id, post_id: post.id, content: '')
  end

  describe 'Associations' do
    it 'belongs to user' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end

  describe 'Validations' do
    describe 'content' do
      it 'must be present' do
      expect(comment.errors[:content]).to eq(["can't be blank"])
      end

      it 'must no exceed 200 characters' do
        content = (1..200).to_a.join
        comment.content = content
        comment.save
        expect(comment.errors[:content]).to eq(["200 characters in comment is the maximum allowed."])
      end
    end
  end
end
