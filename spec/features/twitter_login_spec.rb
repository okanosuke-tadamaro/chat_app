require 'spec_helper'

feature 'testing twitter Oauth' do

  scenario 'create a new user and login through Twitter' do
    login_with_oauth
    visit root_path
    click_link("Sign in with Twitter")
    expect(page).to have_content("Welcome")
  end

end