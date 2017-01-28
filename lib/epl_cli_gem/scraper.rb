class EplCliGem::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.premierleague.com/tables"))
  end

  def scrape_table
    self.get_page.css("tbody.tableBodyContainer tr[data-compseason='54']")
  end

end
