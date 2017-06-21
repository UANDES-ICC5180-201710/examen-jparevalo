class Purcharse < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :game, class_name: 'Game', foreign_key: 'game_id'

  validates :user, presence: true
  validates :game, presence: true
  validates_uniqueness_of :game_id, :scope => :user_id
end
