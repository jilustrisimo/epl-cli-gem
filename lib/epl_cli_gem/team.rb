class EplCliGem::Team

  attr_accessor :name, :rank, :stadium, :url, :website, :games_played, :goal_diff, :points, :won, :drawn, :lost, :match_date, :team_1, :team_2, :time

  @@all = []

  def self.new_from_table(team)

    self.new(
      team.css("span.long").text,
      team.css("span.value").text,
      "https://www.premierleague.com#{team.css("a").attribute("href").text}",
      team.css("td[4]").text,
      team.css("td[5]").text,
      team.css("td[6]").text,
      team.css("td[7]").text,
      team.css("td[10]").text.strip,
      team.css("td.points").text,
      team.css("td.nextMatchCol span.matchInfo").text,
      team.css("td.nextMatchCol span.teamName")[0].text,
      team.css("td.nextMatchCol span.teamName")[1].text,
      team.css("td.nextMatchCol time").text
      )

  end

  def initialize(name=nil, rank=nil, url=nil, games_played=nil, won=nil, drawn=nil, lost=nil, goal_diff=nil, points=nil, match_date=nil, team_1=nil, team_2=nil, time=nil)
    @name = name
    @rank = rank
    @url = url
    @games_played = games_played
    @won = won
    @drawn = drawn
    @lost = lost
    @goal_diff = goal_diff
    @points = points
    @match_date = match_date
    @team_1 = team_1
    @team_2 = team_2
    @time = time
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

  def website
    @website ||= doc.xpath("//div[@class='website']/a").text
  end

  def club_news
    news = doc.css("div.sidebarPush section")[1].css("li")
    news.each do |li|
      puts "Title:"
      puts "#{li.css('span.title').text}\n\n"
      puts "Link:"
      puts "#{li.css('a').attribute('href').value}\n\n"
      puts "- - - - - - - - - - - "
    end
  end
end




#### UNABLE TO SCRAPE ######

  ###Stadium###

  # ##possibly scrape from clubs page?##
  # .xpath("//div[@class='indexInfo clubColourBg']/h4[@class='clubName']").text

  # def stadium_url
  #   @stadium_url ||= Nokogiri::HTML(open(self.url.gsub("overview", "stadium")))
  # end

  # def stadium
  #   binding.pry
  #   @stadium ||= stadium_url.css("div.articleTab p[4]").text.gsub("Stadium address: ", "")
  # end

  ###Fixtures###

  # mainContent > div.wrapper.hasFixedSidebar > nav > div:nth-child(3) > div > div:nth-child(1) > time

  ###Phone###

  # def phone
  #   # @phone ||= stadium_url.css("div.articleTab p[5]").text.gsub("Phone: ", "")
  #   @phone ||= stadium_url.css("div.articleTab p[5]").text.gsub(/[a-zA-Z]\S/, "")
  #   binding.pry
  # end



# if stadium_url.css("div").attribute("data-cli-tab") == "Stadium Information"
#   stadium_url.css("div.articleTab p[4]").text.gsub("Stadium address: ", "")
# end

# stadium_url.css("div.stadiumName a").text
