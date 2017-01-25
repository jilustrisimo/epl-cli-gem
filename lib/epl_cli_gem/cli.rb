class EplCliGem::CLI

  def call
    list_teams
    # ask_for_team
    bye
  end

  def list_teams
    puts "---------------Current League Table---------------"
    puts "Position    Team         Pl         GD        Pts"
    @teams = EplCliGem::Team.sorted
    @teams.each.with_index(1) do |team, i|
      puts "   #{i}  #{team.name}  #{team.games_played}  -  #{team.goal_diff}  -  #{team.points}"
    end

    ask_for_team
  end

  def ask_for_team
    puts "Which team would you like more info on?"
    puts "You can select by rank or name."
    input = gets.strip
    if input.to_i == 1
      puts "Chelsea ..."
    elsif input.to_i == 2
      puts "Arsenal..."
    else
      puts "Invalid Entry"
      self.ask_for_team
    end
    puts "Would you like to learn more about another team?"
    more_info = gets.strip
    list_teams if more_info.downcase == 'y' || more_info.downcase == 'yes'
  end

  def bye
    puts "For Club and Country"
  end
end
