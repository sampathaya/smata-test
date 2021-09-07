require 'rails_helper'

RSpec.describe "Verticals", type: :request do

  # initialize data
  let!(:verticals) { create_list(:vertical, 5) }
  let!(:vertical_id) { verticals.first.id }
  let(:user) { FactoryBot.create(:user, username: 'sampath123', password: 'abcd1234') }

  describe "GET /verticals" do
    before { get '/api/v1/verticals', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    it 'returns verticals' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /vertical' do
    let(:user) { create(:user) }
    let(:valid_name) { { name: "Music12345", user_id: user.id } }
    context 'when the request is valid' do
      before { post '/api/v1/verticals', params: valid_name, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

      it 'creates a vertical record' do
        expect(json['name']).to eq('Music12345')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/verticals', params: { name: '' }, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

      it 'returns status code 422' do
        puts response.body.inspect
        expect(response).to have_http_status(422)
      end

      it 'return a validation message' do
        expect(response.body).to include('is too short')
      end
    end
  end

  describe 'DELETE vertical' do
    before { delete "/api/v1/verticals/#{vertical_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
