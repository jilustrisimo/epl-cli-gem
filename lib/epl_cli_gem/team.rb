class EplCliGem::Team

  attr_accessor :name, :rank, :url, :website, :games_played, :goal_diff, :points, :won, :drawn, :lost

  @@all = []

  def self.new_from_table(team)

    self.new(
      team, #=> team.nodeset: data from scrape, needed for various methods requring scraped data
      team.css("span.long").text, #=> team.name
      team.css("span.value").text, #=> team.rank
      "https://www.premierleague.com#{team.css("a").attribute("href").text}", #=> team.url
      team.css("td[4]").text, #=> team.games_played
      team.css("td[5]").text, #=> team.won
      team.css("td[6]").text, #=> team.drawn
      team.css("td[7]").text, #=> team.lost
      team.css("td[10]").text.strip, #=> team.goal_diff
      team.css("td.points").text #=> team.points
      )

  end

  def initialize(team, name=nil, rank=nil, url=nil, games_played=nil, won=nil, drawn=nil, lost=nil, goal_diff=nil, points=nil)
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
    @@all << self unless @@all.include?(self.name)
  end

  def self.all
    @@all
  end

  def self.sorted
    @@all.sort_by!{|team| team.rank.to_i}
  end

  def match_date

    if @nodeset.css("td.nextMatchCol span.matchInfo").text != ""
      @match_date = @nodeset.css("td.nextMatchCol span.matchInfo").text

    else
      "To Be Determined"
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

    rows = []

      news = doc.css("div.sidebarPush section")[1].css("li")
      news.each do |li|
        rows << [li.css('span.title').text]
        rows << :separator
      end

      table = Terminal::Table.new :title => "Latest Club News\nRead more at #{self.website}", :rows => rows
      table.align_column 0, :center

      puts table
  end
end
