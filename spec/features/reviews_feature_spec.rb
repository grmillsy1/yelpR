require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: "Tim's Topple"}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link "Review Tim's Topple"
    fill_in "Thoughts", with: "Rubbish"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content('Rubbish')

  end
end
