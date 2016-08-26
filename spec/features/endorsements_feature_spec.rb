require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_up
    create_restaurant
    leave_review('It was an abomination', '3')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse' #are we endorsing restaurants or the review of the restaurants?
    expect(page).to have_content('1 endorsement')
  end

end
