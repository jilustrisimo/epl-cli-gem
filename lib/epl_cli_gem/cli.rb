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
    puts "You can select by rank or team name."
    input = gets.strip

    if input.to_i == 0
      team = @teams.find{|team| team.name.downcase == input.downcase}
      if team != nil then print_team(team) else ask_for_team end

    else input.to_i.between?(1, 20)
      team = @teams.find{|team| team.rank == input}
      print_team(team)
    # elsif input.to_i == 2
    #   puts "Arsenal..."
    # else
    #   puts "Invalid Entry"
    #   ask_for_team
    end
    puts "Would you like to learn more about another team?"
    more_info = gets.strip
    list_teams if more_info.downcase == 'y' || more_info.downcase == 'yes'
  end

  def print_team(team)
    puts "\n-------------------#{team.name}----------------------\n"
    puts "Position:           #{team.rank}"
    puts "Points:             #{team.points}"
    puts "Stadium:            #{team.stadium}"
    puts "Website:            #{team.website}\n\n"
  end

  def bye
    puts "For Club and Country"
  end
end


# if input == 0
#   #iterate over @@all and find matching team.name
#   EplCliGem::Team.all.find{|team| team.name == input}
