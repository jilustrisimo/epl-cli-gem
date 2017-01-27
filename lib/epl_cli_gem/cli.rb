class EplCliGem::CLI

  def call
    EplCliGem::Scraper.new.make_teams
    start
  end

  def start
    list_teams
    puts "Which team would you like more information on?"
    puts "Please select by team name or current position."
    puts "(Not case sensitive)"
    input = gets.strip

    ask_for_team(input)

    puts "Would you like to learn more about another team?\nYes\nNo"
    input = gets.strip

    input.downcase == 'y' || input.downcase == 'yes' ? start : bye
  end

  def list_teams

    rows = []

    @teams = EplCliGem::Team.sorted
    @teams.each.with_index(1) do |team, i|
      rows << [i, team.name, team.games_played, team.goal_diff, team.points]
    end

    table = Terminal::Table.new :title => "Current League Table",
    :headings => ['POSN', 'Team', 'PL', 'GD', 'Pts'], :rows => rows
    table.align_column 0, :center

    puts table
    puts ""
  end

  def ask_for_team(input)

    if input.to_i == 0
      team = @teams.find{|team| team.name.downcase == input.downcase}
      team != nil ? print_team(team) : spell_check

    elsif input.to_i.between?(1, 20)
      team = @teams.find{|team| team.rank == input}
      print_team(team)

    else
      spell_check
    end
  end

  def print_team(team)

    rows = []

    rows << ['Position', team.rank]
    rows << ['Points', team.points]
    rows << ['Games Played', team.games_played]
    rows << ["", team.won]
    rows << ['Drawn', team.drawn]
    rows << ['Lost', team.lost]
    rows << ['Goal Difference', team.goal_diff]
    rows << ['Team Website', team.website]  ##### << maybe move

    table = Terminal::Table.new :title => "#{team.name}", :rows => rows

    puts table

    rows.clear
    rows << [team.team_1, team.time, team.team_2]

    next_match = Terminal::Table.new :title => "Next Match\n#{team.match_date}", :rows => rows

    puts next_match
  end
  # def print_team(team)
  #   puts "                     #{team.name}\n\n"
  #   # puts "-------------------------|-------------------------\n\n"
  #   puts "Position:               #{team.rank}"
  #   puts "Points:                 #{team.points}"
  #   puts "Games Played:           #{team.games_played}"
  #   puts "Won:                    #{team.won}"
  #   puts "Drawn:                  #{team.drawn}"
  #   puts "Lost:                   #{team.lost}"
  #   puts "Goal Difference:        #{team.goal_diff}"
  #   puts "Website:                #{team.website}\n\n"
  #   puts "                     Next Match"
  #   puts "-------------------------|-------------------------\n\n"
  #   puts "              #{team.match_date}"
  #   puts "                   #{team.team_1} #{team.time} #{team.team_2}\n\n"
  #   puts "                 Latest Club News"
  #   puts "-------------------------|-------------------------\n\n"
  #
  #   team.club_news
  #
  # end

  def bye
    puts "\nFor Club and Country"
    sleep 1
    abort
  end

  def spell_check
    puts "\nInvalid Entry, please check spelling or \nselect a number between 1 and 20.\n\n"
    sleep 2
    start
  end

end
