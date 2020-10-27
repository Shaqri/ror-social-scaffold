require 'rails_helper'


RSpec.describe 'Like requests' do
  let(:user) do
    User.create(email: 'victor@victor.com', name: 'victor', password: 'victor')
  end
  let(:user_params) do
    {
      user: {
        email: 'victor@victor.com',
        password: 'victor'

      }
    }
  end

  describe 'POST /create' do
    it 'creates a new like and redirects to previous page' do
      user
      post_params = {
        post: {
          user_id: User.first.id,
          content: 'Post content'
        }
      }
      like_params = {
        like: {
          user_id: User.first.id,
          post_id: 1
        }
      }
      post user_session_path, params: user_params
      post posts_path, params: post_params
      expect(response).to have_http_status(302)
      post post_likes_path(Post.first.id), params: like_params
      expect(response).to have_http_status(302)
    end
  end
end
