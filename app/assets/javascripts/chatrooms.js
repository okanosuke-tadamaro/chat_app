function msgLayout(currentUser) {
  $(document).ready(function() {
    var msg = $('.message-box');
    for (var i = 0; i < msg.length; i++) {
      if (msg.eq(i).attr('id') == currentUser) {
        msg.eq(i).addClass('right');
      }
    }
  });
}