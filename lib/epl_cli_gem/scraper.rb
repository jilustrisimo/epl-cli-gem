class EplCliGem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.premierleague.com/tables"))
  end

  def scrape_table
    binding.pry
    self.get_page.css("tbody.tableBodyContainer tr")
  end

end

teams = self.get_page.css("tbody.tableBodyContainer tr").select{|tr| tr['data-compseason'] == "54"}

teams.each do |team| puts team.css("span.long").text end #=> team.name
teams.each do |team| puts team.css("a").attribute("href").text end #=> team.url
teams.each do |team| puts team.css("td[4]").text end #=> team.games_played
teams[4].css("td[10]").text.strip #=> team.goal_diff
teams[4].css("td.points").text #=> team.points
