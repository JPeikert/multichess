class Game < ApplicationRecord
  belongs_to :room

  def self.start(uuid1, uuid2)
    white, black = [uuid1, uuid2].shuffle

    ActionCable.server.broadcast "player_#{white}", {action: "game_start", msg: "white"}
    ActionCable.server.broadcast "player_#{black}", {action: "game_start", msg: "black"}

  end

  def self.make_move(uuid, data)
    opponent = opponent_for(uuid)
    move_string = "#{data["from"]}-#{data["to"]}"

    ActionCable.server.broadcast "player_#{opponent}", {action: "make_move", msg: move_string}
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
