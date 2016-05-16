App.room = App.cable.subscriptions.create("RoomChannel", {
  received: function(data) {
    return $('#messages').append(data['message']);
  }},
  $(document).on("click", "#clicker", function() {
    $("#message_area").preventDefault;
    $("#message_area").submit();
    $("#message_area").val("");
  })
);