require 'rails_helper'

RSpec.describe 'Friendship requests' do
  let(:sign_up) do
    User.create(name: 'victor', email: 'victor@victor.com', )
  end
  describe 'GET /index' do
    it 'returns page status message and correct body response' do
      get()
    end
  end
end
