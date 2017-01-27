class EplCliGem::CLI

  def call
    EplCliGem::Scraper.new.make_teams
    puts "Welcome the the English Premier League CLI gem\n\n"
    puts "If the output looks messy please\nmake sure your CLI is long enough.\n\n"
    sleep 3
    start
  end

  def start
    list_teams
    puts "*You can always exit the program by typing EXIT.*\n\n"
    puts "Which team would you like more information on?"
    puts "Please select by team name or current position."
    puts "(Not case sensitive)"
    input = gets.strip


    ask_for_team(input)

    puts "Type Yes to learn more about another team\n otherwise enter any other key to exit"
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

    puts ""
    puts table
    puts ""
  end

  def ask_for_team(input)

    if input.downcase == 'exit'
      bye

    elsif input.to_i == 0
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
    rows << ['Won', team.won]
    rows << ['Drawn', team.drawn]
    rows << ['Lost', team.lost]
    rows << ['Goal Difference', team.goal_diff]

    table = Terminal::Table.new :title => "#{team.name}", :rows => rows

    puts ""
    puts table

    rows.clear
    rows << [team.team_1, team.time, team.team_2]

    next_match = Terminal::Table.new :title => "Next Match\n#{team.match_date}", :rows => rows
    next_match.align_column 0, :center
    next_match.align_column 1, :center
    next_match.align_column 2, :center

    puts next_match

    team.club_news
  end

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
