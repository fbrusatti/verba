require 'spec_helper'

feature 'Testing signin' do
  given(:user) { create(:user) }

  scenario "using email credentials" do
    visit root_path
    click_link 'Login'

    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password

    click_button 'Sign in'
    page.should be_logged_in
  end


  scenario 'with correct facebook credentials' do
    login_with :facebook, user

    visit root_path
    page.should be_logged_in
  end

  scenario "with incorrect facebook credentials" do
    login_with :facebook, user, :invalid_credentials

    visit root_path
    page.should be_logged_out
  end
end
