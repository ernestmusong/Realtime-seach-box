require 'rails_helper'

RSpec.describe Search, type: :model do
  before :all do
    @first_search = Seach.create(query: 'how are you', ip_address: 1)
  end

  after :all do
    Search.destroy_all
  end

  describe '#Validation' do
    it 'Search query  must not be nil' do
      @first_search.query = nil
      expect(@first_search).not_to be_valid
    end
    it 'Search IP  must not be nil' do
      @first_search.ip_address = nil
      expect(@first_search).not_to be_valid
    end
  end
end
