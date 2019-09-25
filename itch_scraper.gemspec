lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "itch_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "itch_scraper"
  spec.version       = ItchScraper::VERSION
  spec.authors       = ["KHong"]
  spec.email         = ["albtrossfacefall@gmail.com"]

  spec.summary       = "Scrapes information off of itch.io in a CLI application"
  spec.description   = 
  spec.homepage      = "https://github.com/khongcodes2/ItchScraper"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = "https://github.com/khongcodes2/ItchScraper"
  spec.metadata["source_code_uri"] = "https://github.com/khongcodes2/ItchScraper"
  spec.metadata["changelog_uri"] = "https://github.com/khongcodes2/ItchScraper"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "nokogiri", "~>1.6"

  spec.add_runtime_dependency "colorize"
end
