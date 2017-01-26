class EplCliGem::Team

  attr_accessor :name, :rank, :stadium, :url, :website, :games_played, :goal_diff, :points

  @@all = []

  def self.new_from_table(team)

    self.new(
      team.css("span.long").text,
      team.css("span.value").text,
      "https://www.premierleague.com#{team.css("a").attribute("href").text}",
      team.css("td[4]").text,
      team.css("td[10]").text.strip,
      team.css("td.points").text
      )

    # team_2 = self.new
    # team_2.name = "Arsenal"
    # team_2.rank = "2"
    # team_2.stadium = "Emirates Stadium"
    # team_2.url = "https://www.premierleague.com/clubs/1/Arsenal/overview"
    # team_2.website = "https://www.arsenal.com/"
    # team_2.games_played = "22"
    # team_2.goal_diff = "+27"
    # team_2.points = "47"
    #
    # @@all << team_2
    # @@all << team_1
  end

  def initialize(name=nil, rank=nil, url=nil, games_played=nil, goal_diff=nil, points=nil)
    @name = name
    @rank = rank
    @url = url
    @games_played = games_played
    @goal_diff = goal_diff
    @points = points
    @@all << self
  end


  def self.all
    @@all
  end

  def self.sorted
    @@all.sort_by!{|team| team.rank}
  end

end
