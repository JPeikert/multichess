App.room = App.cable.subscriptions.create("RoomChannel", {

  connected: function() {
    printMessage("Waiting for opponent...");
  },
  received: function(data) {
    switch (data.action) {
      case "game_start":
        App.board.position("start");
        App.board.orientation(data.msg);
        printMessage("Game started! You play as " + data.msg + ".");
        break;
      case "make_move":
        [source, target] = data.msg.split("-");
        App.board.move(data.msg);
        App.chess.move({
          from: source,
          to: target,
          promotion: "q"
        });
        App.board.position(App.chess.fen())
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