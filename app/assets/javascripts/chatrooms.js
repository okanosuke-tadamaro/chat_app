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
  var roomName = window.location.pathname.split("/")[2];
  var lastMessage = $('.message-box').eq(0).text();
  $.ajax({
    url: '/get_messages',
    method: 'get',
    dataType: 'json',
    data: {
      name: roomName,
      timestamp: (new Date($.now()))
    }
  }).done(function(data) {
    console.log(data.ranking_data[0][0]);
    console.log(data.ranking_data[0][1]);
  });
}