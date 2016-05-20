class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def chess
  end

  def test
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages.all
  end

  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to rooms_path
    else
      render new_room_path
    end
  end

  def join
    @room = Room.find(params[:id])
    if @room.player1 == nil
      @room.player1 = cookies.signed[:user_id]
      @room.save
  #    redirect_to room_path(@room)
    elsif @room.player2 == nil
      @room.player2 = cookies.signed[:user_id]
      @p1 = User.find(@room.player1)
      @p2 = User.find(cookies.signed[:user_id])
      @p1.opponent = @p2.id
      @p2.opponent = @p1.id
      @p1.save
      @p2.save
      Game.start(@room.player1, @room.player2)
      @room.save
    end
  end

  def exit
    @room = Room.find(params[:id])
    if @room.player1 == cookies.signed[:user_id]
      @room.player1 = nil
      @p1 = User.find(cookies.signed[:user_id])
      @p1.opponent = nil
      @p1.save
      @room.game.forfeit(@room.player1)
      @room.save
    elsif @room.player2 == cookies.signed[:user_id]
      @room.player2 = nil
      @p2 = User.find(cookies.signed[:user_id])
      @p2.opponent = nil
      @p2.save
      Game.forfeit(@room.player2)
      @room.save
    end
    redirect_to room_path(@room)
  end

  def clear_all
    @room = Room.find(params[:id])
    @p1 = User.find(@room.player1)
    @p1.opponent = nil
    @p1.save
    @room.player1 = nil
    @room.save
    @p2 = User.find(@room.player2)
    @p2.opponent = nil
    @p2.save
    
    @room.player2 = nil
    @room.save
    redirect_to room_path(@room)
  end

  private
    def room_params
      params.require(:room).permit(:name)
    end
end
