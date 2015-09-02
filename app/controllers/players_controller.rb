class PlayersController < ApplicationController
  before_filter :load_players
  def index
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_path, notice: "Player created!"
    else
      flash.now[:alert] = @player.errors.full_messages.join(", ")
      render :index
    end
  end

  private

  def load_players
    @players = Player.order(:rank)
  end

  def player_params
    params[:player].slice(:name)
  end
end
