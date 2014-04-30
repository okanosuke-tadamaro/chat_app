require 'spec_helper'

feature 'Signing in' do

  # scenario "should create a chatroom object " do
        # Chatroom.create(name: 'mark')
        # capybara dsl goes here

  scenario "A user can create a chat room" do
        visit('/')
        within('/') do
        fill_in 'name', with: 'mark'
        click_button 'Create Chatroom'
        expect(page).to have_content('mark')
      end

    end

    # scenario "should redirect to show page of created chatroom" do
    #     User.create(username: 'abray', email: 'adam@ga.co',
    #     password: 'qwerty', password_confirmation: 'qwerty')
    #     # capybara dsl goes here
    # end


end

