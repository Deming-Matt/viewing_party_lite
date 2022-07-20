require 'rails_helper'

RSpec.describe 'register page' do
  # When a user visits the '/register' path they should see a form to register.
  # The form should include:
  #  Name
  #  Email (must be unique)
  #  Register Button
  # Once the user registers they should be taken to a dashboard page '/users/:id', where :id is the id for the user that was just created.
  it 'allows a user to create a registration and redirects to their page' do

    visit '/registration'

    expect(page).to have_content("Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password Confirmation")
    expect(page).to have_button("Register")

    fill_in "Name", with: "Sam Smith"
    fill_in "Email", with: "ssmith22@gmail.com"
    fill_in "Password", with: "Cat"
    fill_in "Password Confirmation", with: "Cat"
    click_button "Register"
    expect(current_path).to eq(root_path)
  end

  describe 'sad path' do
    it 'forgets to fill out form correctly' do

      visit '/registration'

      expect(page).to have_content("Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password Confirmation")
      expect(page).to have_button("Register")

      fill_in "Name", with: "Sam Smith"
      fill_in "Email", with: "ssmith22@gmail.com"
      fill_in "Password", with: "Cat1"
      fill_in "Password Confirmation", with: "Cat"
      click_button "Register"
      expect(current_path).to eq("/registration")
      # expect(page).to have_content("Password confirmation doesn't match Password")
      # expect(flash[:error]).to be_present
    end
  end
end
