class EplCliGem::CLI

  def call
    EplCliGem::Scraper.new.make_teams
    list_teams
  end

  def list_teams
    puts "\n---------------Current League Table---------------"
    puts "Position    Team         Pl         GD        Pts"
    @teams = EplCliGem::Team.sorted
    @teams.each.with_index(1) do |team, i|
      puts "   #{i}      #{team.name}             #{team.games_played}   #{team.goal_diff}    #{team.points}"
    end
    puts ""
    ask_for_team
  end

  def ask_for_team
    puts "Which team would you like more info on?"
    puts "You can select by rank or team name."
    input = gets.strip

    if input.to_i == 0
      team = @teams.find{|team| team.name.downcase == input.downcase}
      if team != nil then print_team(team) else spell_check end

    elsif input.to_i.between?(1, 20)
      team = @teams.find{|team| team.rank == input}
      print_team(team)

    else
      spell_check
    end

    puts "Would you like to learn more about another team?\nYes\nNo"
    more = gets.strip
    if more.downcase == 'y' || more.downcase == 'yes' then list_teams else bye end
  end

  def print_team(team)
    puts "\n-------------------#{team.name}----------------------"
    puts "Position:           #{team.rank}"
    puts "Points:             #{team.points}"
    puts "Stadium:            #{team.stadium}"
    puts "Website:            #{team.website}\n\n"
  end

  def bye
    puts "For Club and Country"
    sleep 2
    abort
  end

private

  def spell_check
    puts "\nInvalid Entry, please check spelling or \nselect a # between 1 and 20.\n\n"
    ask_for_team
  end

end
