# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    Seek.create(uuid)
  end

  def unsubscribed
    # TO DO saving game state and waiting for reconnection of a player 
    Seek.remove(uuid)
    Game.forfeit(uuid)
  end


  def make_move(data)
    Game.make_move(uuid, data)
  end
  #def speak (data)
    #ActionCable.server.broadcast 'room_channel', message: data['message'] - just "echo"
   # Message.create! content: data['message']
  #end
end
