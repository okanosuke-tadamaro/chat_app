function msgLayout(currentUser) {
  var msg = $('.message-box');
  var box = $('.arrow_box');
  for (var i = 0; i < msg.length; i++) {
    var boxText = box.eq(i).text();
    var msgText = msg.eq(i).text();
    if (msg.eq(i).attr('id') == currentUser) {
      msg.eq(i).removeClass('left');
      msg.eq(i).addClass('right');
    }
    if (boxText.indexOf("http") >= 0) {
      box.eq(i).text("");

      box.eq(i).append($('<a>').attr('href', msgText).text(msgText));
      if (boxText.indexOf(".gif") >= 0 || boxText.indexOf(".jpg") >= 0 || boxText.indexOf(".png") >= 0) {
        box.eq(i).append($('<img>').attr('src', msgText).attr('class', 'message-image'));
      }
    }
  }
}

function addMessage(data) {
  var newMsgs = data.newMsgs;
  var chatBox = $('.chat-box');
  for (var i = 0; i < newMsgs.length; i++) {
    var msgBox = $('<div>').addClass('message-box').hide();
    var avatar = $('<img>').attr('src', newMsgs[i].avt);
    var avatarBox = $('<div>').addClass('message-avatar').addClass('avatar').append(avatar);
    var arrowBox = $('<div>').addClass('arrow_box');
    var messageContent = $('<div>').addClass('message-content');
    var msgText = newMsgs[i].message.content;

    msgBox.attr('id', data.user).addClass('left');
    msgBox.attr('msg_id', newMsgs[i].msg_id);
    if (msgText.indexOf("http") >= 0) {
      arrowBox.append($('<a>').attr('href', msgText).text(msgText)).appendTo(messageContent);
      if (msgText.indexOf(".gif") >= 0 || msgText.indexOf(".jpg") >= 0 || msgText.indexOf(".png") >= 0) {
        arrowBox.append($('<img>').attr('src', msgText).attr('class', 'message-image')).appendTo(messageContent);
      }
    } else {
      arrowBox.text(msgText).appendTo(messageContent);
    }
    msgBox.append(avatarBox);
    msgBox.append(messageContent);
    chatBox.prepend(msgBox);
    msgBox.slideDown(200);
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
      var roomLink = $('<a>').attr('href', '/chatrooms/' + updatedRooms[i][0]).text(updatedRooms[i][0] + " : " + updatedRooms[i][1]);
      roomListText.eq(i).append(roomLink);
    }
  });
}

function ranking(data) {
  var rankingData = data.rankings;
  rankingData.sort(function(a,b){
    return a[1]-b[1];
  });
  var rankingBox = $('#ranking_box');
  rankingBox.empty();
  for(var i = 0; i < rankingData.length; i++) {
    var userInfo = $('<div>').text(rankingData[i][1] + ' ' + rankingData[i][0]);
    rankingBox.append(userInfo);
  }
}

function grabMessages() {
  var roomName = $('.room-name').text();
  var latestMsgID = $('.message-box').eq(0).attr('msg_id');
  $.ajax({
    url: '/get_messages',
    method: 'get',
    dataType: 'json',
    data: {
      name: roomName,
      msg_id: latestMsgID
    }
  }).done(function(data) {
    addMessage(data);
    ranking(data);
  });
}

