function msgLayout(currentUser) {
  var msg = $('.message-box');
  for (var i = 0; i < msg.length; i++) {
    if (msg.eq(i).attr('id') == currentUser) {
      msg.eq(i).removeClass('left');
      msg.eq(i).addClass('right');
    }
  }
}

function ranking(data) {
  var rankingData = data.rankings;
  rankingData.sort(function(a,b){return a[1]-b[1]});
  var rankingBox = $('#ranking_box');
  rankingBox.empty();
  for(var i = 0; i < rankingData.length; i++) {
    var userInfo = $('<div>').text(rankingData[i][1] + ' ' + rankingData[i][0]);
    rankingBox.append(userInfo);
  }
  // var ranked_users = $('.ranked_users');
  

  // for (var i = 0; i < newMsgs.length; i++) {
  //   $('<p>').text(rankingData[i].content).appendTo('#rank_div');
  //   console.log(rankingData[i]);
  // }
  // $(ra)appendTo('.ranked_user')
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
    console.log(data.ranking_data);
    var newMsgs = data.newMsgs;
    var chatBox = $('.chat-box');
    for (var i = 0; i < newMsgs.length; i++) {
      var msgBox = $('<div>').addClass('message-box').hide();
      msgBox.attr('id', data.user).addClass('left');
      $('<p>').text(newMsgs[i].content).appendTo(msgBox);
      chatBox.prepend(msgBox);
      msgBox.slideDown(400);
    }
    ranking(data);

  });
}