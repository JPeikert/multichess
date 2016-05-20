class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users
  has_one :game, dependent: :destroy

  validates_presence_of :name
end
