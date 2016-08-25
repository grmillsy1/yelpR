require 'rails_helper'
# require 'helper_spec'

feature 'reviewing' do

  before do
    sign_up
    create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link "Review New restaurant"
    fill_in "Thoughts", with: "Rubbish"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content('Rubbish')

  end

  scenario 'displays average rating for all reviews' do
    leave_review('great', '3')
    click_link('Sign out')
    visit ('/')
    click_link('Sign up')
    fill_in('Email', with: "test2@test.com")
    fill_in('Password', with: "test123")
    fill_in('Password confirmation', with: "test123")
    click_button('Sign up')
    leave_review('so so', '5')
    expect(page).to have_content('★★★★☆')
  end

end
