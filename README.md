# ItchScraper

Welcome to ItchScraper, a gem that uses scraping to display basic navigable menus and projects of itch.io.
(What is itch.io? see: https://itch.io/docs/general/about)

The categories of projects that can be viewed are:
1. Games
2. Tools
3. Game assets
4. Comics
5. Books
6. Physical games
7. Soundtracks
8. Game mods
9. Everything else

Itch's sort methods for each of the above categories are
1. Popular
2. New & Popular
3. Top sellers
4. Top rated
5. Most recent

Due to the limitations of my current Ruby ability:
- This program can only display up to the 30th item under each category sort method.
- The detail/individual view of each item is a little roughly formatted right now: each project page is formatted personally by its own creator, so there is no template all projects follow.
I'll seek to address these in future version updates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itch_scraper_test'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itch_scraper_test

## Usage

The basic commands which are generally available are:
- Integers 1..10 to access menus and items
- 'q' to quit

The following commands are available based on context (instructions will be printed at each menu):
- 'b' to go back one menu
- 'n' to go to the next page of 10 items
- 'p' to go to the previous page of 10 items
- 'v' to view previously-viewed items
- 'r' to access the root menu


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khongcodes2/itch_scraper_test.

## Authors

Kevin Hong - https://github.com/khongcodes2/
