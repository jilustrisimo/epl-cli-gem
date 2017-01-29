# English Premier League CLI  [![Gem Version](https://badge.fury.io/rb/epl_cli_gem.svg)](https://badge.fury.io/rb/epl_cli_gem)

This Ruby Gem provides a CLI to view the current English Premier League table as well as some basic information for each club.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'epl_cli_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install epl_cli_gem

## Usage

Type the following and follow the on screen prompts.

    $ epl


## Example CLI Output

    +------+----------------------+----+-----+-----+
    |             Current League Table             |
    +------+----------------------+----+-----+-----+
    | POSN | Team                 | PL | GD  | Pts |
    +------+----------------------+----+-----+-----+
    |  1   | Chelsea              | 22 | +32 | 55  |
    |  2   | Arsenal              | 22 | +27 | 47  |
    |  3   | Tottenham Hotspur    | 22 | +29 | 46  |
    |  4   | Liverpool            | 22 | +24 | 45  |
    |  5   | Manchester City      | 22 | +15 | 43  |
    |  6   | Manchester United    | 22 | +12 | 41  |
    |  7   | Everton              | 22 | +10 | 36  |
    |  8   | West Bromwich Albion | 22 | +2  | 32  |
    |  9   | Stoke City           | 22 | -6  | 28  |
    |  10  | West Ham United      | 22 | -7  | 28  |
    |  11  | Southampton          | 22 | -4  | 27  |
    |  12  | Bournemouth          | 22 | -7  | 26  |
    |  13  | Burnley              | 22 | -9  | 26  |
    |  14  | Watford              | 22 | -13 | 24  |
    |  15  | Leicester City       | 22 | -13 | 21  |
    |  16  | Middlesbrough        | 22 | -7  | 20  |
    |  17  | Swansea City         | 22 | -25 | 18  |
    |  18  | Crystal Palace       | 22 | -11 | 16  |
    |  19  | Hull City            | 22 | -27 | 16  |
    |  20  | Sunderland           | 22 | -22 | 15  |
    +------+----------------------+----+-----+-----+

After input is given:

    +-----------------+-----+
    |    Manchester City    |
    +-----------------+-----+
    | Position        | 5   |
    | Points          | 43  |
    | Games Played    | 22  |
    | Won             | 13  |
    | Drawn           | 4   |
    | Lost            | 5   |
    | Goal Difference | +15 |
    +-----------------+-----+
    +------+-----+-----+
    |    Next Match    |
    | To Be Determined |
    +------+-----+-----+

    +------+-----+-----+
    +--------------------------------------------------+
    |                 Latest Club News                 |
    |           Read more at www.mancity.com           |
    +--------------------------------------------------+
    |     Caballero aiming to relive Wembley dream     |
    +--------------------------------------------------+
    |        De Bruyne identifies Palace threat        |
    +--------------------------------------------------+
    |       Gabriel Jesus backed by Brazil stars       |
    +--------------------------------------------------+
    | Things We Love: Clichy's comparison and City ink |
    +--------------------------------------------------+
    +--------------------------------------------------+

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jilustrisimo/epl_cli_gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
