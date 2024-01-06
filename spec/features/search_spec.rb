require 'rails_helper'

RSpec.describe 'Seaches', type: :feature do
  before(:each) do
    visit searches
    fill_in 'how are you'
  end
  describe 'Display results' do
    scenario 'should display No results found' do
      visit search
      fill_in 'how are you'
      expect(page).to have_content('No results found')
    end
  end
  describe 'Results page' do
    scenario 'should display search form' do
      visit searches
      expect(page).to have_content('Search')
    end
  end
end
