class EplCliGem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.premierleague.com/tables"))
  end

  def scrape_table
    # sleep 3
    self.get_page.css("tbody.tableBodyContainer tr")
  end

  def make_teams
    teams = scrape_table.select{|tr| tr['data-compseason'] == "54"}
    teams.each{|team| EplCliGem::Team.new_from_table(team)}
  end

end
