class EplCliGem::CLI

  def call
    puts ""
    puts "Welcome to the English Premier League CLI gem\n\n".colorize(:cyan)
    puts "If the output looks messy please\nmake sure your CLI is long enough.\n\n".colorize(:light_red).underline
    EplCliGem::Scraper.new.make_teams
    start
  end

  def start

    eXit = "EXIT".colorize(:red).underline
    yes = "Yes".colorize(:light_cyan)
    list_teams
    puts "You can always exit the program by typing #{eXit}.\n\n"
    puts "Which team would you like more information on?"
    puts "Please select by team name or current position."
    puts "(Not case sensitive)".colorize(:red)
    input = gets.strip


    ask_for_team(input)

    puts "Type #{yes} to learn more about another team\n otherwise enter any other key to #{eXit}."
    input = gets.strip

    input.downcase == 'y' || input.downcase == 'yes' ? start : bye
  end

  def list_teams

    rows = []

    @teams ||= EplCliGem::Team.sorted
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

    match = []
    match << [team.team_1, team.match_time, team.team_2]

    next_match = Terminal::Table.new :title => "Next Match\n#{team.match_date}", :rows => match
    next_match.align_column 0, :center
    next_match.align_column 1, :center
    next_match.align_column 2, :center

    puts next_match

    team.club_news
  end

  def bye
    for_clu = "For Clu".colorize(:red).on_blue
    b_and_C = "b and C".colorize(:light_white).on_blue
    ountry = "ountry".colorize(:red).on_blue
    puts "#{for_clu}#{b_and_C}#{ountry}"
    sleep 1
    abort
  end

  def spell_check
    puts ""
    puts "Invalid Entry, please check spelling".on_red
    puts "or select a number between 1 and 20.".on_red
    puts ""
    sleep 2
    start
  end

end
