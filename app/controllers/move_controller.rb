class MoveController < ApplicationController
    def create
        @game = Game.find(params[:game_id])
        @game.move!(params[:index].to_i)

        redirect_to @game
    end
end
