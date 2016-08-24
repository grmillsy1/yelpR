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
    Restaurant.create(name: 'Mikes magic mushroom parlor')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content 'Mikes magic mushroom parlor'
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
  let!(:mmmp){ Restaurant.create(name: 'Mikes magic mushroom parlor')}

  scenario 'lets a user view a restaurant' do
    visit '/restaurants'
    click_link 'Mikes magic mushroom parlor'
    expect(page).to have_content 'Mikes magic mushroom parlor'
    expect(current_path).to eq "/restaurants/#{mmmp.id}"
  end
end

context 'editing restaurants' do

  before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }
  before do
    sign_up
  end

  scenario 'let a user edit a restaurant' do
   visit '/restaurants'
   click_link 'KFC'
   click_link 'Edit KFC'
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
  end
  before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

  scenario 'removes a restaurant when a user clicks a delete link' do
    visit '/restaurants'
    click_link 'KFC'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
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
end
