class EplCliGem::Team

  attr_accessor :name, :rank, :stadium, :url, :website, :games_played, :goal_diff, :points

  @@all = []

  def self.new_from_table
    team_1 = self.new
    team_1.name = "Chelsea"
    team_1.rank = "1"
    team_1.stadium = "Stamford Bridge"
    team_1.url = "https://www.premierleague.com/clubs/4/Chelsea/overview"
    team_1.website = "https://www.chelseafc.com/"
    team_1.games_played = "22"
    team_1.goal_diff = "+32"
    team_1.points = "55"

    team_2 = self.new
    team_2.name = "Arsenal"
    team_2.rank = "2"
    team_2.stadium = "Emirates Stadium"
    team_2.url = "https://www.premierleague.com/clubs/1/Arsenal/overview"
    team_2.website = "https://www.arsenal.com/"
    team_2.games_played = "22"
    team_2.goal_diff = "+27"
    team_2.points = "47"

    @@all << team_2
    @@all << team_1
  end

  def self.add_team(team)
    # @@all << team unless @@all.include?(team.name)
    # @@all << team_2 # unless @@all.include?(team_2.name)
    # @@all << team_1 # unless @@all.include?(team_1.name)
    # should return teams array sorted by rank.
    # sorted
  end

  def self.all
    @@all
  end

  def self.sorted
    @@all.sort_by!{|team| team.rank}
  end

end
