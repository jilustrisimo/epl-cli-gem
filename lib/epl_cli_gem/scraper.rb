class EplCliGem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.premierleague.com/tables"))
  end

  def scrape_table
    self.get_page.css("tbody.tableBodyContainer tr")
  end

  def make_teams
    teams = scrape_table.select{|tr| tr['data-compseason'] == "54"}
    teams.each{|team| EplCliGem::Team.new_from_table(team)}
  end

end

# teams = self.get_page.css("tbody.tableBodyContainer tr").select{|tr| tr['data-compseason'] == "54"}

# teams.each do |team| puts team.css("span.long").text end #=> team.name
# teams[0].css("span.value").text.to_i #=> team.rank
# teams.each do |team| puts team.css("a").attribute("href").text end #=> team.url
# teams.each do |team| puts team.css("td[4]").text end #=> team.games_played
# teams[4].css("td[10]").text.strip #=> team.goal_diff
# teams[4].css("td.points").text #=> team.points
