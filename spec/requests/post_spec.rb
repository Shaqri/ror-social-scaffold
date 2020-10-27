require 'rails_helper'

RSpec.describe 'Post requests' do
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

  describe 'GET index' do
    it 'displays post index page and found http request' do
      user
      get new_user_session_path, params: user_params
      get ('/')
      expect(response).to have_http_status(302)

    end
  end

  describe 'POST create' do
    it 'creates a new post and redirect to previous page' do
      user
      post_params = {
        user_id: User.first.id,
        content: 'Post content'
      }

      get new_user_session_path, params: user_params
      get posts_path, params: post_params
      expect(response).to have_http_status(302)
    end
  end
end
