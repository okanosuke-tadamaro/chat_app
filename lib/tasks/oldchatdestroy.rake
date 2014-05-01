task timed_destroy: :environment do
  desc "Destroys chatrooms older than 24 hours at midnight"
  puts "Destroying old chatrooms..."
  Chatroom.all.each do |room|
    room.timed_destroy
  end
  puts "Bye Bye rooms!"
end


