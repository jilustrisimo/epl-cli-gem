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
    @@all.sort_by!{|team| team.rank.to_i}
  end

  def doc
    sleep 5
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def website
    binding.pry
    @website ||= doc.xpath("//div[@class='website']/a").text
  end

  # def stadium
  #   @stadium ||=
  # end
end
