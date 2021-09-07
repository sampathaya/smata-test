require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, username: 'sampath1', password: 'abcd1234') }
    it 'authenticates the user' do
      post '/api/v1/login', params: { username: user.username, password: 'abcd1234' }
      expect(response).to have_http_status(:created)
      expect(json).to eq({
                           'id' => user.id,
                           'username' => 'sampath1',
                           'token' => AuthenticationTokenService.call(user.id)
                         })
    end
    it 'returns error when username does not exist' do
      post '/api/v1/login', params: { username: 'ac', password: 'password' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'No such user'
                         })
    end
    it 'returns error when password is incorrect' do
      post '/api/v1/login', params: { username: user.username, password: 'incorrect' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'Incorrect password '
                         })
    end
  end
end
