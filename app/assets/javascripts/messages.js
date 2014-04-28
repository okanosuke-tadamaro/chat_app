function createMessage() {
  $('#new-message').focus();
  var newMsg = $('#new-message').val();
  var roomName = window.location.pathname.split("/")[2];
  $.ajax({
    url: '/messages',
    method: 'post',
    dataType: 'json',
    data: {
      content: newMsg,
      room_name: roomName
    }
  }).done(function(data) {
    var chatBox = $(".chat-box");
    var msgBox = $('<div>').addClass("message-box").hide();
    $('<p>').text(newMsg).appendTo(msgBox);
    chatBox.prepend(msgBox);
    msgBox.slideDown(500);
    $('textarea').val("");
  });
}