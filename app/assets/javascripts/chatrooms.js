function msgLayout(currentUser) {
  $(document).ready(function() {
    var msg = $('.message-box');
    for (var i = 0; i < msg.length; i++) {
      if (msg.eq(i).attr('id') == currentUser) {
        msg.eq(i).removeClass('left');
        msg.eq(i).addClass('right');
      }
    }
  });
}

// function grabAvatars(currentUser) {
//   var emotions = ['happy', 'sad', 'mad', 'rofl', 'confused', 'surprised'];
//   var result = [];
//   for(var i = 0; i < emotions.length; i++) {
//     $.get(('https://s3.amazonaws.com/s3-sample-pt/' + currentUser + '_' + emotions[i] + '.png'), function(data) {
//       console.log(data);
//     });
//   }
// }