class Game < ApplicationRecord
  belongs_to :room

  def self.start(uuid1, uuid2, room)
    white, black = [uuid1, uuid2].shuffle
    @room = room

    ActionCable.server.broadcast "player_#{white}", {action: "game_start", msg: "white", room: room}
    ActionCable.server.broadcast "player_#{black}", {action: "game_start", msg: "black", room: room}
    logger.info "startujemy"

  end

  def self.make_move(uuid, data)
    logger.info "GAME MAKE_MOVE ERROR"
    opponent = opponent_for(uuid)
    move_string = "#{data["from"]}-#{data["to"]}"
    logger.info "data room: !!  #{data["room"]}"
    ActionCable.server.broadcast "player_#{opponent}", {action: "make_move", msg: move_string, room: data["room"]}
  end

  def self.opponent_for(uuid)
    User.find(uuid).opponent
  end

  def self.forfeit(uuid)
    if winner = opponent_for(uuid)
      ActionCable.server.broadcast "player_#{winner}", {action: "opponent_forfeits"}
    end
  end
end
