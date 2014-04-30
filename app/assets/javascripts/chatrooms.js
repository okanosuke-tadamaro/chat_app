function msgLayout(currentUser) {
  var msg = $('.message-box');
  for (var i = 0; i < msg.length; i++) {
    if (msg.eq(i).attr('id') == currentUser) {
      msg.eq(i).removeClass('left');
      msg.eq(i).addClass('right');
    }
  }
}

function addMessage(data) {
  console.log(data);
  var newMsgs = data.newMsgs;
  var chatBox = $('.chat-box');
  for (var i = 0; i < newMsgs.length; i++) {
    var msgBox = $('<div>').addClass('message-box').hide();
    var avatar = $('<img>').attr('src', newMsgs[i].avt);
    var avatarBox = $('<div>').addClass('message-avatar').addClass('avatar').append(avatar);
    var arrowBox = $('<div>').addClass('arrow_box');
    var messageContent = $('<div>').addClass('message-content');

    msgBox.attr('id', data.user).addClass('left');
    arrowBox.text(newMsgs[i].message.content).appendTo(messageContent);
    msgBox.append(avatarBox);
    msgBox.append(messageContent);
    chatBox.prepend(msgBox);
    msgBox.slideDown(200);
  }
}

function ranking(data) {

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
    addMessage(data);
    ranking(data);
  });
}