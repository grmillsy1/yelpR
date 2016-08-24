
def sign_up
  visit ('/')
  click_link('Sign up')
  fill_in('Email', with: "test@test.com")
  fill_in('Password', with: "test123")
  fill_in('Password confirmation', with: "test123")
  click_button('Sign up')
end
