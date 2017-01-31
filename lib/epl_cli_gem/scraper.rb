class EplCliGem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.premierleague.com/tables"))
  end

  def scrape_table
    self.get_page.css("tbody.tableBodyContainer tr[data-compseason='54']").each do |row|

        EplCliGem::Team.new(
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
  end

end
