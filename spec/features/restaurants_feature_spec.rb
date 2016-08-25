require 'rails_helper'
require_relative 'helper_spec'


feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

context 'restaurants have been added' do
  before do
    sign_up
    create_restaurant
  end

  scenario 'display restaurants' do
    expect(page).to have_content 'New restaurant'
    expect(page).not_to have_content 'No restaurants yet'
  end
end

context 'creating restaurants' do
  before do
    sign_up
  end

  scenario 'prompts user to fill out a form, then displays the new restaurant' do
   visit ('/restaurants')
   click_link 'Add a restaurant'
   fill_in 'Name', with: 'Mikes magic mushroom parlor'
   click_button 'Create Restaurant'
   expect(page).to have_content 'Mikes magic mushroom parlor'
   expect(current_path).to eq '/restaurants'
 end

 context 'an invalid restaurant' do
   it 'does not let you submit a name that is too short' do
   visit '/restaurants'
   click_link 'Add a restaurant'
   fill_in 'Name', with: 'Mm'
   click_button 'Create Restaurant'
   expect(page).not_to have_css 'h2', text: 'Mm'
   expect(page).to have_content 'error'
   end
 end


end

context 'viewing restaurants' do
  before do
    sign_up
    create_restaurant
  end
  scenario 'lets a user view a restaurant' do
    restaurant = Restaurant.first
    visit '/restaurants'
    click_link 'New restaurant'
    expect(page).to have_content 'New restaurant'
    expect(current_path).to eq "/restaurants/#{restaurant.id}"
  end
end

context 'editing restaurants' do

  before do
    sign_up
    create_restaurant
  end

  scenario 'let a user edit a restaurant' do
   visit '/restaurants'
   click_link 'New restaurant'
   click_link 'Edit New restaurant'
   fill_in 'Name', with: 'Kentucky Fried Chicken'
   fill_in 'Description', with: 'Deep fried goodness'
   click_button 'Update Restaurant'
   expect(page).to have_content 'Kentucky Fried Chicken'
   expect(page).to have_content 'Deep fried goodness'
   expect(current_path).to eq '/restaurants'
  end

end


context 'deleting restaurants' do
  before do
    sign_up
    create_restaurant
  end
  # before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

  scenario 'removes a restaurant when a user clicks a delete link' do
    visit '/restaurants'
    click_link 'New restaurant'
    click_link 'Delete New restaurant'
    expect(page).not_to have_content 'New restaurant'
    expect(page).to have_content 'Restaurant deleted successfully'
  end

end

context 'not signed in' do
  scenario 'does not allow user to create restaurant unless signed in' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
    expect(page).not_to have_link 'Create Restaurant'
  end
end

scenario 'a user can only a edit a restaurant they created' do
     sign_up
     create_restaurant
     click_link 'Sign out'
     sign_up
     visit '/restaurants'
     click_link 'Edit New Restaurant'
     expect(page).to have_content 'You did not create this restaurant'
   end
end
