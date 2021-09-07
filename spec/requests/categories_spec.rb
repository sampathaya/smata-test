require 'rails_helper'

RSpec.describe "Categories", type: :request do

  # initialize data
  let!(:categories) { create_list(:category, 10) }
  let!(:category_id) { categories.first.id }
  let(:user) { FactoryBot.create(:user, username: 'sampath123', password: 'abcd1234') }

  describe "GET /categories" do
    before { get '/api/v1/categories', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    it 'returns categories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /categories/:id' do
    before { get "/api/v1/categories/#{category_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    context 'when category exists' do
      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the category item' do
        expect(json['id']).to eq(category_id)
      end
    end

    context 'when the category does not exists' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return not found error message' do
        expect(response.body).to include("Couldn't find Category with 'id'=0");
      end
    end
  end

  describe 'POST /categories/:id' do
    let(:vertical) { create(:vertical) }
    let(:valid_attributes) do
      {
        name: 'category name',
        state: 'active',
        vertical_id: vertical.id
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/categories', params: valid_attributes, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

      it 'creates a category record' do
        puts '--------------------'
        puts valid_attributes
        puts response.body
        expect(json['name']).to eq('category name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/categories', params: {  }, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

      it 'returns status code 422' do
        puts response.body.inspect
        expect(response).to have_http_status(422)
      end

      it 'return a validation message' do
        expect(response.body).to include('is too short')
      end
    end
  end

  describe 'PUT /categories/:id' do
    let(:valid_attributes) { { name: 'Sharp Knives' } }
    before { put "/api/v1/categories/#{category_id}", params: valid_attributes, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    context 'when category exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the category' do
        updated_item = Category.find(category_id)
        expect(updated_item.name).to match(/Sharp Knives/)
      end
    end
    context 'when the category does not exist' do
      let(:category_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Category with 'id'=0")
      end
    end
  end

  describe 'DELETE category' do
    before { delete "/api/v1/categories/#{category_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
