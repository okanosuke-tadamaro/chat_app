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
      var user = data.user;
      var msgBox = $('<div>').addClass('message-box').hide();
      msgBox.attr('id', user).addClass('right');
      $('<p>').text(newMsg).appendTo(msgBox);
      chatBox.prepend(msgBox);
      msgBox.slideDown(400);
      $('textarea').val("");
    });
  }
}