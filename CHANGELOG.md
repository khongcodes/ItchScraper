# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2017-09-25
### Added
- Added a changelog
- Added Notes
- All scraping now handled through Scraper class - interestingly, this has caused the program to run slightly faster
- Extended colorizing

### Changed
- Some instance variable names more transparently reflects their intended purposes
- Changed nest_nav values to map more cleanly to the menu_names array ("Root" is now 0 instead of 1)
- Made previously-viewed nest_nav lvl 4
- Updated Gemspec info

### Removed
- Removed open-uri dependency - we'll see if this actually does anything

## [0.1.1] - 2017-09-17
### Added
- Beginning Colorize tests
- Added 'r' input to randomly select at Sort-Method list menu


## [0.1.0] - 2017-09-13
### Added
- Navigating menu functional