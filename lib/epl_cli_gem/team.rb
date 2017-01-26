class EplCliGem::Team

  attr_accessor :name, :rank, :stadium, :url, :website, :games_played, :goal_diff, :points, :phone

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
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def stadium_url
    @stadium_url ||= Nokogiri::HTML(open(self.url.gsub("overview", "stadium")))
  end

  def website
    @website ||= doc.xpath("//div[@class='website']/a").text
  end

  def stadium
    @stadium ||= stadium_url.css("div.articleTab p[4]").text.gsub("Stadium address: ", "")
  end

  def phone
    # @phone ||= stadium_url.css("div.articleTab p[5]").text.gsub("Phone: ", "")
    @phone ||= stadium_url.css("div.articleTab p[5]").text.gsub(/[a-zA-Z]\S/, "")
    binding.pry
  end

end

# if stadium_url.css("div").attribute("data-cli-tab") == "Stadium Information"
#   stadium_url.css("div.articleTab p[4]").text.gsub("Stadium address: ", "")
# end
