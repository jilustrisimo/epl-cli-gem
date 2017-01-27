class EplCliGem::CLI

  def call
    EplCliGem::Scraper.new.make_teams
    start
  end

  def start
    list_teams
    puts "Which team would you like more information on?"
    puts "Please select by team name or current rank."
    puts "(Not case sensitive)"
    input = gets.strip

    ask_for_team(input)

    puts "Would you like to learn more about another team?\nYes\nNo"
    input = gets.strip
    # if input.downcase == 'y' || input.downcase == 'yes' then list_teams else bye end
    input.downcase == 'y' || input.downcase == 'yes' ? list_teams : bye

  end

  def list_teams
    puts "\n---------------Current League Table------------------"
    puts "Position    Team         Pl         GD        Pts"
    @teams = EplCliGem::Team.sorted
    @teams.each.with_index(1) do |team, i|
      puts "   #{i}      #{team.name}      #{team.games_played}   #{team.goal_diff}    #{team.points}"
    end
    puts ""
    # ask_for_team
  end

  def ask_for_team(input)
    # puts "Which team would you like more information on?"
    # puts "You can select by rank or team name."
    # input = gets.strip

    if input.to_i == 0
      team = @teams.find{|team| team.name.downcase == input.downcase}
      # if team != nil then print_team(team) else spell_check end
      team != nil ? print_team(team) : spell_check

    elsif input.to_i.between?(1, 20)
      team = @teams.find{|team| team.rank == input}
      print_team(team)

    else
      spell_check
    end

  end

  def print_team(team)
    puts "\n------------------#{team.name}--------------------"
    puts "Position:               #{team.rank}"
    puts "Points:                 #{team.points}"
    puts "Games Played:           #{team.games_played}"
    puts "Won:                    #{team.won}"
    puts "Drawn:                  #{team.drawn}"
    puts "Lost:                   #{team.lost}"
    puts "Goal Difference:        #{team.goal_diff}"
    puts "Website:                #{team.website}\n\n"
    puts "Next Match:             #{team.match_date}"
    puts "               #{team.team_1} |#{team.time}| #{team.team_2}\n\n"
    puts "\n------------------Latest Club News----------------"

    team.club_news

  end

  def bye
    puts "\nFor Club and Country"
    sleep 2.5
    abort
  end

private

  def spell_check
    sleep 1
    puts "\nInvalid Entry, please check spelling or \nselect a number between 1 and 20.\n\n"
    ask_for_team
  end

end
