class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users
  has_one :game, dependent: :destroy

  validates_presence_of :name

  def playersNumber

    @num = 0
    if self.player1 != nil
      @num += 1
    end
    if self.player2 != nil
      @num += 1
    end

    return @num
  end
end
