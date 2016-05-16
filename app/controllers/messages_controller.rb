class MessagesController < ApplicationController

  def create
    @message = Message.create(message_params)
    @message.room = Room.find(params[:message][:room])
    @message.save

    #$#ActionCable.server.broadcast "messages",
    #  message: @message.content,
    #  room: @message.room
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
