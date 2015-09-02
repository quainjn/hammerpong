require 'spec_helper'

describe PlayersController do
  describe "GET #index" do
    let(:me) { Player.create(name: "me", rank: 1 ) }
    let(:you) { Player.create(name: "you", rank: 2 ) }

    it "renders the index page with players" do
      get :index
      expect(response).to be_success
      expect(response).to render_template :index
      expect(assigns(:players)).to match_array Player.all
      expect(assigns(:player)).to_not be_persisted
    end
  end

  describe "POST #create" do
    it "creates a new active player with no rank" do
      expect {
        post :create, player: {name: "Name"}
      }.to change(Player, :count).by(1)
      player = Player.last
      expect(player.name).to eq "name"
      expect(player.rank).to be_nil
      expect(player).to be_active
    end
  end
end
