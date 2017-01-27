class EplCliGem::Team

  attr_accessor :name, :rank, :url, :website, :games_played, :goal_diff, :points, :won, :drawn, :lost

  @@all = []

  def self.new_from_table(team)

    self.new(
      team, #=> data from scrape, needed for various methods requring scraped data
      team.css("span.long").text, #=> team.name
      team.css("span.value").text, #=> team.rank
      "https://www.premierleague.com#{team.css("a").attribute("href").text}", #=> team.url
      team.css("td[4]").text, #=> team.games_played
      team.css("td[5]").text, #=> team.won
      team.css("td[6]").text, #=> team.drawn
      team.css("td[7]").text, #=> team.lost
      team.css("td[10]").text.strip, #=> team.goal_diff
      team.css("td.points").text #=> team.points
      # team.css("td.nextMatchCol span.matchInfo").text, #=> team.match_date
      # team.css("td.nextMatchCol span.teamName")[0],#.text, #=> team.team_1
      # team.css("td.nextMatchCol span.teamName")[1],#.text, #=> team.team_2
      # team.css("td.nextMatchCol time")#.text #=> team.time
      )

  end

  def initialize(team, name=nil, rank=nil, url=nil, games_played=nil, won=nil, drawn=nil, lost=nil, goal_diff=nil, points=nil)
    # match_date="TBD", team_1="TBD", team_2="TBD", time="TBD"
    @nodeset = team
    @name = name
    @rank = rank
    @url = url
    @games_played = games_played
    @won = won
    @drawn = drawn
    @lost = lost
    @goal_diff = goal_diff
    @points = points
    # @match_date = match_date
    # @team_1 = team_1
    # @team_2 = team_2
    # @time = time
    @@all << self
  end

  def self.all
    @@all
  end

  def self.sorted
    @@all.sort_by!{|team| team.rank.to_i}
  end

  def match_date
    # binding.pry
    if @nodeset.css("td.nextMatchCol span.matchInfo").text != ""
      @match_date = @nodeset.css("td.nextMatchCol span.matchInfo").text
    else
      "TBD"
    end
  end

  def team_1
    if @nodeset.css("td.nextMatchCol span.teamName")[0] != nil
      @team_1 = @nodeset.css("td.nextMatchCol span.teamName")[0].text
    end
  end

  def team_2
    if @nodeset.css("td.nextMatchCol span.teamName")[1] != nil
    @team_2 = @nodeset.css("td.nextMatchCol span.teamName")[1].text
    end
  end

  def time
    if @nodeset.css("td.nextMatchCol time").text != ""
    @time = @nodeset.css("td.nextMatchCol time").text
    end
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
      puts "- - - - - - - - - - - - - - - - - "
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
