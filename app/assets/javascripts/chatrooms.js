function msgLayout(currentUser) {
  var msg = $('.message-box');
  for (var i = 0; i < msg.length; i++) {
    if (msg.eq(i).attr('id') == currentUser) {
      msg.eq(i).removeClass('left');
      msg.eq(i).addClass('right');
    }
  }
}

function recentRoomTimes() {
  $.ajax({
    url: '/chatrooms',
    method: 'get',
    dataType: 'json',
  }).done(function(updatedRooms) {
    var roomListText = $('.room_list_text');
    roomListText.empty();
    for (var i = 0; i < roomListText.length; i++) {
      var roomLink = $('<a>').attr('href', '/chatrooms/' + updatedRooms[i][0]).text(updatedRooms[i][0] + " - " + updatedRooms[i][1]);
      roomListText.eq(i).append(roomLink);
    }
  });
}

function ranking(rankings) {

}

function grabMessages() {
  var roomName = $('.room-name').text();
  $.ajax({
    url: '/get_messages',
    method: 'get',
    dataType: 'json',
    data: {
      name: roomName,
      timestamp: $.now()
    }
  }).done(function(data) {
    var newMsgs = data.newMsgs;
    var chatBox = $('.chat-box');
    for (var i = 0; i < newMsgs.length; i++) {
      var msgBox = $('<div>').addClass('message-box').hide();
      msgBox.attr('id', data.user).addClass('left');
      $('<p>').text(newMsgs[i].content).appendTo(msgBox);
      chatBox.prepend(msgBox);
      msgBox.slideDown(400);
    }
    ranking(data.rankingData);
  });
}

