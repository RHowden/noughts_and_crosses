class Game < ApplicationRecord
    serialize :board, type: Array, coder: JSON

    attribute :board, default: -> { 9.times.collect { nil } }
    attribute :current_player, default: -> { ["X", "O"].sample }

    def state
        return :x_wins if victory_for("X")
        return :o_wins if victory_for("O")
        return :draw if board.none? { |a| a.nil? }
        :in_play 
    end

    def state_label
        if state == :draw
            "Game is drawn"    
        elsif state == :x_wins 
            "X has won"
        elsif state == :o_wins
            "O has won"
        end
    end

    def move!(index)
        return unless state == :in_play

        board[index] = current_player

        self.current_player = current_player == "X" ? "O" : "X"

        save!
    end
      
    private

    # This method uses pattern matching. It compares the board array
    # to all the possible victory conditions.
    def victory_for(player)
        case board
        in [
                ^player, ^player, ^player, 
                _, _, _,
                _, _, _] |
            [
                _, _, _, 
                ^player, ^player, ^player, 
                _, _, _] |
            [ 
                _, _, _, 
                _, _, _, 
                ^player, ^player, ^player]
          true
        in [
                ^player, _, _, 
                ^player, _, _, 
                ^player, _, _] |
            [
                _, ^player, _,
                _, ^player, _,
                _, ^player, _] |
            [ 
                _, _, ^player, 
                _, _, ^player, 
                _, _, ^player]
          true
        in [
                ^player, _, _, 
                _, ^player, _, 
                _, _, ^player] |
            [
                _, _, ^player,
                _, ^player, _,
                ^player, _, _] 
            true
        else
            false
        end
    end
end
