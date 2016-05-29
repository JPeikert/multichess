$(document).on("turbolinks:load", function() {
  $('.rooms.show').ready(function() {
    var board, cfg, room;
    room = $('#room_number').attr('data-value');
    console.log("num " + room);
    board = "chessboard" + room;
    App.chess[room] = new Chess();
    cfg = {
      draggable: true,
      pieceTheme: "../assets/chesspieces/wikipedia/{piece}.png",
      showNotation: false,
      onDragStart: (function(_this) {
        return function(source, piece, position, orientation) {
          return !(App.chess[room].game_over() || 
            (App.chess[room].turn() === "w" && piece.search(/^b/) !== -1) || 
            (App.chess[room].turn() === "b" && piece.search(/^w/) !== -1) || 
            (orientation === "white" && piece.search(/^b/) !== -1) || 
            (orientation === "black" && piece.search(/^w/) !== -1));
        };
      })(this),
      onDrop: (function(_this) {
        return function(source, target) {
          var move;
          move = App.chess[room].move({
            from: source,
            to: target,
            promotion: "q",
          });
          if (move === null) {
            return "snapback";
          } else {
            move.room = room;
            console.log("move: " + move+ " move.to " + move.to + " room: " + room + " move.room: " + move.room);
            App.room.perform("make_move", move);
            console.log("AFTER move: " + move + " room: " + room)
            return App.board[room].position(App.chess[room].fen(), false);
          }
        };
      })(this)
    };
    
    return App.board[room] = ChessBoard(board, cfg);
  });
});