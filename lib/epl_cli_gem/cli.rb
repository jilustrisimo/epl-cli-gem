class EplCliGem::CLI

  def call
    EplCliGem::Team.list_teams
    bye
  end

  # def list_table
  #   puts "Current League Table:"
  #   puts <<-DOC
  #         Team       Pl  -  GD  -  Pts
  #     1. Chelsea     22  - +32  -  55
  #     2. Arsenal     22  - +27  -  47
  #   DOC
  #   ask_for_team
  # end

  def self.ask_for_team
    puts "Which team would you like more info on?"
    puts "You can select by rank or name."
    input = gets.strip
    if input.to_i == 1
      puts "Chelsea ..."
    elsif input.to_i == 2
      puts "Arsenal..."
    else
      puts "Invalid Entry"
      ask_for_team
    end
    puts "Would you like to learn more about another team?"
    more_info = gets.strip
    EplCliGem::Team.list_teams if more_info.downcase == 'y' || more_info.downcase == 'yes'
  end

  def bye
    puts "For Club and Country"
  end
end
