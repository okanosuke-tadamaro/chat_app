function msgLayout(currentUser) {
  var msg = $('.message-box');
  for (var i = 0; i < msg.length; i++) {
    if (msg.eq(i).attr('id') == currentUser) {
      msg.eq(i).removeClass('left');
      msg.eq(i).addClass('right');
    }
  }
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
  });
}