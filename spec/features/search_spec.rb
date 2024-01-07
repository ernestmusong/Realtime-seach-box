require 'rails_helper'

RSpec.describe 'Instant Search', type: :feature do
  scenario 'displays search results as the user types', js: true do
    visit searches_path

    # Find the search input field and type a search query
    fill_in 'search', with: 'how'
    sleep 1
    expect(page).to have_selector('#search_results', visible: true)
  end
end
