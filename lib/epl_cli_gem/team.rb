class EplCliGem::Team

  attr_accessor :name, :rank, :url, :website, :games_played, :goal_diff, :points, :won, :drawn, :lost

  @@all = []

  def self.make_teams
    @@table ||= EplCliGem::Scraper.new.scrape_table
    @@table.each{|row| self.new_from_table(row)}
  end

  def self.new_from_table(row)

    self.new(
      row, #=> self.nodeset: data from scrape, needed for various methods requiring scraped data
      row.css("span.long").text, #=> self.name
      row.css("span.value").text, #=> self.rank
      "https://www.premierleague.com#{row.css("a").attribute("href").text}", #=> self.url
      row.css("td[4]").text, #=> self.games_played
      row.css("td[5]").text, #=> self.won
      row.css("td[6]").text, #=> self.drawn
      row.css("td[7]").text, #=> self.lost
      row.css("td[10]").text.strip, #=> self.goal_diff
      row.css("td.points").text #=> self.points
      )

  end

  def initialize(row, name=nil, rank=nil, url=nil, games_played=nil, won=nil, drawn=nil, lost=nil, goal_diff=nil, points=nil)
    @nodeset = row
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
      # matches are sometimes pending due to scheduling, if statement in place
      # to stop NoMethodError from .text when there is no text to return

    if @nodeset.css("td.nextMatchCol span.matchInfo").text != ""
      @match_date = @nodeset.css("td.nextMatchCol span.matchInfo").text

    else
      "To Be Determined"
    end
  end

  def team_1
    # matches are sometimes pending due to scheduling, if statement in place
    # to stop NoMethodError from .text when there is no text to return

    if @nodeset.css("td.nextMatchCol span.teamName")[0] != nil
      @team_1 = @nodeset.css("td.nextMatchCol span.teamName")[0].text
    end
  end

  def team_2
    # matches are sometimes pending due to scheduling, if statement in place
    # to stop NoMethodError from .text when there is no text to return

    if @nodeset.css("td.nextMatchCol span.teamName")[1] != nil
    @team_2 = @nodeset.css("td.nextMatchCol span.teamName")[1].text
    end
  end

  def match_time
    # matches are sometimes pending due to scheduling, if statement in place
    # to stop NoMethodError from .text when there is no text to return

    if @nodeset.css("td.nextMatchCol time").text != ""
    @match_time = @nodeset.css("td.nextMatchCol time").text
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
