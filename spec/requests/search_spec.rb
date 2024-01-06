require 'rails_helper'
RSpec.describe 'Searches', type: :request do
  describe '  /searches' do
    it 'return http success' do
      post searches
      expect(response).to have_http_status(200)
    end
  end
end
