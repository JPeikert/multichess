App.room = App.cable.subscriptions.create({channel: "RoomChannel" },  {

  connected: function() {
    printMessage("Waiting for opponent...");
  },
  received: function(data) {
    console.log("I received some data!! " + data.action)
    room = $('#room_number').attr('data-value');
    switch (data.action) {
      case "game_start":
        if (data.room == room) {
          App.board[data.room].position("start");
          App.board[data.room].orientation(data.msg);
          printMessage("Game started! You play as " + data.msg + ". Your room: " + data.room);
        }
        break;
      case "make_move":
        if (data.room == room) {
          console.log("Data I received: " + data.msg + " AND: " + data.room);
          [source, target] = data.msg.split("-");
          App.board[data.room].move(data.msg);
          App.chess[data.room].move({
            from: source,
            to: target,
            promotion: "q"
          });
          App.board[data.room].position(App.chess[data.room].fen())
          console.log("And finished with move");
        }
        break;
      case "opponent_forfeits":
        printMessage("Opponent forfeits. You win!");
      case "speak":      
        $('#messages').append(data['msg']);
        break;
    }
  }},

  $(document).on("click", "#clicker", function() {
    $("#message_area").preventDefault;
    $("#message_area").submit();
    $("#message_area").val("");
  }),

  printMessage = function(message) {
    $("#chess_messages").append("<p>" + message + "</p>");
  }

);