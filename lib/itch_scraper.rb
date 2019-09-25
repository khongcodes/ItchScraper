require "nokogiri"
require 'open-uri'
require 'colorize'
require_relative "itch_scraper/version"
require_relative "itch_scraper/menumodule"
require_relative "itch_scraper/scraper"
require_relative "itch_scraper/objects"
require_relative "itch_scraper/cli"

module ItchScraper
  class Error < StandardError; end
  # Your code goes here...
end
