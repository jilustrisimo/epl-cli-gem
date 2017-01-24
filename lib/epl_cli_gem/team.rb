class EplCliGem::Team

  def self.list_teams
    puts "Current League Table:"
    puts <<-DOC
          Team       Pl  -  GD  -  Pts
      1. Chelsea     22  - +32  -  55
      2. Arsenal     22  - +27  -  47
    DOC
    EplCliGem::CLI.ask_for_team

    # should return teams array sorted by rank.
  end

end

# team_1 = self.new
# team_1.name = "Chelsea"
# team_1.rank = "1"
# team_1.stadium = "Stamford Bridge"
# team_1.url = "https://www.premierleague.com/clubs/4/Chelsea/overview"
# team_1.website = "https://www.chelseafc.com/"
# team_1.games_played = "22"
# team_1.goal_diff = "+32"
# team_1.points = "55"
