class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # TODO change rooms to both players
    ActionCable.server.broadcast "player_#{message.room.player1}", {action: "speak", msg: render_message(message)}
    ActionCable.server.broadcast "player_#{message.room.player2}", {action: "speak", msg: render_message(message)}
    #ActionCable.server.broadcast "player_#{uuid1}", {action: "speak", msg: render_message(message)}
    #ActionCable.server.broadcast "player_#{uuid2}", {action: "speak", msg: render_message(message)}
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
    end

end
