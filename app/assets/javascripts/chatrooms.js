function createChatroom() {
  var newRoomName = prompt("What's the name of the new room?");
  $.ajax({
    url: '/chatrooms',
    method: 'post',
    dataType: 'json',
    data: {
      name: newRoomName
    }
  }).done(function(newRoom) {
    //REDIRECT TO NEW ROOM
  });
}