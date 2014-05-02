# require 'spec_helper'

# feature 'Creating Chatroom' do

#   # scenario "should create a chatroom object " do
#         # Chatroom.create(name: 'mark')
#         # capybara dsl goes here

#   scenario "A user can create a chat room" do
#         visit('/')
#         within('/') do
#         click_button 'Sign in with Twitter'
#         expect(page).to have_content('Register your Avatars!' || "Recent Rooms")
#       end

#     end

#     # scenario "should redirect to show page of created chatroom" do
#     #     User.create(username: 'abray', email: 'adam@ga.co',
#     #     password: 'qwerty', password_confirmation: 'qwerty')
#     #     # capybara dsl goes here
#     # end


# end

describe Chatroom do
  pending "user can create a chatroom after signing in with Twitter"
end

