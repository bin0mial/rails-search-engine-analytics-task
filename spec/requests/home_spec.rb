require 'rails_helper'

RSpec.describe '/', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get root_url
      expect(response).to be_successful
    end

    it 'renders page correctly' do
      get root_url
      expect(response.body).to include('Search for:')
      expect(response.body).to include('Search for article...')
    end
  end
end
