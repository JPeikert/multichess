class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def chess
  end

  def test
  end

  def show
    @id = params[:id]
    @room = Room.find(params[:id])
    if ((@room.player1 == nil || @room.player2 == nil) &&
        User.find(cookies.signed[:user_id]).opponent == nil) ||
        (@room.player1 == cookies.signed[:user_id] || @room.player2 == cookies.signed[:user_id] )
        
      @message = Message.new
      @messages = @room.messages.all
    else
      redirect_to rooms_path
    end
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
      ActionCable.server.broadcast "player_#{@room.player1}", {action: "player1_joins", msg: @room.player1}
  #    redirect_to room_path(@room)
    elsif @room.player2 == nil && @room.player1 != cookies.signed[:user_id]
      @room.player2 = cookies.signed[:user_id]
      @p1 = User.find(@room.player1)
      @p2 = User.find(cookies.signed[:user_id])
      @p1.opponent = @p2.id
      @p2.opponent = @p1.id
      @p1.save
      @p2.save
      @room.save
      ActionCable.server.broadcast "player_#{@room.player1}", {action: "player2_joins", msg: @room.player2}
      ActionCable.server.broadcast "player_#{@room.player2}", {action: "player2_joins", msg: @room.player2}
      Game.start(@room.player1, @room.player2, @room.id)
    end
  end

  def exit
    @room = Room.find(params[:id])
    if @room.player1 == cookies.signed[:user_id]
      @p1 = User.find(cookies.signed[:user_id])
      if @p1.opponent != nil
        Game.forfeit(@room.player1)
        @p1.opponent = nil
        @p1.save
      end
      @room.player1 = nil
      @room.save
    elsif @room.player2 == cookies.signed[:user_id]
      @p2 = User.find(cookies.signed[:user_id])
      if @p2.opponent != nil       
        Game.forfeit(@room.player2)
        @p2.opponent = nil
        @p2.save
      end
      @room.player2 = nil
      @room.save
    end
    if @room.player1 == nil && @room.player2 == nil
      @room.messages.destroy_all
      @room.destroy
    end
    redirect_to rooms_path #room_path(@room)
  end

  def clear_all
    @room = Room.find(params[:id])
    if @room.player1 != nil
      @p1 = User.find(@room.player1)
      @p1.opponent = nil
      @p1.save
      @room.player1 = nil
      @room.save
    end

    if @room.player2 != nil
      @p2 = User.find(@room.player2)
      @p2.opponent = nil
      @p2.save
      @room.player2 = nil
      @room.save
    end

    @room.messages.each { |x| x.destroy }
    
    redirect_to room_path(@room)
  end

  private
    def room_params
      params.require(:room).permit(:name)
    end
end
