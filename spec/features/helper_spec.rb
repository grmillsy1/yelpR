
def sign_up
  visit ('/')
  click_link('Sign up')
  fill_in('Email', with: "test@test.com")
  fill_in('Password', with: "test123")
  fill_in('Password confirmation', with: "test123")
  click_button('Sign up')
end

def create_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'New restaurant'
  fill_in 'Description', with: 'Description'
  click_button 'Create Restaurant'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review New restaurant'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
