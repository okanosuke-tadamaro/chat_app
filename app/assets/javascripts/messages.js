function createMessage() {
  $('#new-message').focus();
  var newMsg = $('#new-message').val();
  var roomName = $('.room-name').text();

  if (newMsg !== "") {
    $.ajax({
      url: '/messages',
      method: 'post',
      dataType: 'json',
      data: {
        content: newMsg,
        room_name: roomName,
      }
    }).done(function(data) {
      var chatBox = $('.chat-box');
      var msgBox = $('<div>').addClass('message-box').hide();
      var user = data.user;
      var avatarBox = $('<div>').addClass('message-avatar').addClass('avatar');
      var avatarImage = $('#' + user + '_' + data.obj.emotion).clone();
      avatarImage.appendTo(avatarBox);
      avatarBox.appendTo(msgBox);
      msgBox.attr('id', user).addClass('right');
      msgBox.attr('msg_id', data.msg_id);
      var messageContent = $('<div>').addClass('message-content');
      var arrowBox = $('<div>').addClass('arrow_box');
      arrowBox.text(data.obj.content).appendTo(messageContent);
      messageContent.appendTo(msgBox);
      chatBox.prepend(msgBox);
      msgBox.slideDown(400);
      $('#new-message').val("");
    });
  }
}