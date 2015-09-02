class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  include MatchesHelper

  def create
    params[:match] ||= {}
    params[:match][:winner] = Player.find_by_name(params[:winner_name].downcase)
    params[:match][:loser] = Player.find_by_name(params[:loser_name].downcase)

    @match = Match.new(params[:match])
    if @match.save
      redirect_to matches_path, notice: "Match saved!"
    else
      flash.now[:alert] = @match.errors.full_messages.join(", ")
      @matches = Match.order("occured_at desc")
      render :index
    end
  end

  def destroy
    Match.find(params[:id]).destroy
    redirect_to matches_path
  end

  def index
    @match = Match.new
    @matches = Match.order("occured_at desc")
  end

  def rankings
    @rankings = Player.active.ranked
    last_30_days_matches = Match.where("occured_at >= ?", 30.days.ago).order("occured_at asc")
    last_90_days_matches = Match.where("occured_at >= ?", 90.days.ago).order("occured_at asc")
    @last_30_days_rankings = calculate_rankings(last_30_days_matches)
    @last_90_days_rankings = calculate_rankings(last_90_days_matches)
  end

  def players
    if params[:q]
      query = params[:q].downcase + '%'
      names = Player.where(["LOWER(name) LIKE ?", query]).collect(&:name)
    else
      names = Player.all.collect(&:name)
    end

    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
end
