$(document).on("turbolinks:load", function() {
  $('.rooms.show').ready(function() {
    var board, cfg;
    App.chess = new Chess();
    cfg = {
      draggable: true,
      pieceTheme: "../assets/chesspieces/wikipedia/{piece}.png",
      showNotation: false,
      onDragStart: (function(_this) {
        return function(source, piece, position, orientation) {
          return !(App.chess.game_over() || 
            (App.chess.turn() === "w" && piece.search(/^b/) !== -1) || 
            (App.chess.turn() === "b" && piece.search(/^w/) !== -1) || 
            (orientation === "white" && piece.search(/^b/) !== -1) || 
            (orientation === "black" && piece.search(/^w/) !== -1));
        };
      })(this),
      onDrop: (function(_this) {
        return function(source, target) {
          var move;
          move = App.chess.move({
            from: source,
            to: target,
            promotion: "q"
          });
          if (move === null) {
            return "snapback";
          } else {
            App.room.perform("make_move", move);
            return App.board.position(App.chess.fen(), false);
          }
        };
      })(this)
    };
    console.log("num " + $('#room_number').attr('data-value'));
    board = "chessboard" + $("#room_number").attr('data-value');
    return App.board = ChessBoard(board, cfg);
  });
});