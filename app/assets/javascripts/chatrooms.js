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

// function msgLayout() {
//   $(document).ready(function() {
//     var msg = $('.message-box');
//     for (var i = 0; i < msg.length; i++) {
//       if (msg.eq(i).hasClass('left')) {
//         if (msg.eq(i).attr('id') === msg.eq(i - 1).attr('id')) {
//           msg.removeClass('left');
//           msg.addClass('right');
//         }
//       }
//     }
//   });
// }