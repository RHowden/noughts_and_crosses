class Game < ApplicationRecord
    serialize :board, type: Array, coder: JSON

    attribute :board, default: -> { 9.times.collect { nil } }
    attribute :current_player, default: -> { ["X", "O"].sample }

end
