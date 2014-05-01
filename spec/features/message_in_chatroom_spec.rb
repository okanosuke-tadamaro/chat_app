require 'spec_helper'

feature "user can type and create messages that are viewed in a chatroom" do

  background { User.create(username: "pjwl33", token: "abcd")}
  background { Chatroom.create(name: "test_room")}

  scenario "should show up the messages in the chatroom" do
    visit('/chatrooms/test_room')
    fill_in("new-message", with: "test comment!")
    click_button("Send")

    expect(page).to have_content("test comment!")
  end
end