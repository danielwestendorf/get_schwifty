$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "get_schwifty/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "get_schwifty"
  s.version     = GetSchwifty::VERSION
  s.authors     = ["Daniel Westendorf"]
  s.email       = ["daniel@prowestech.com"]
  s.summary     = %q{Render view partials with ActiveJob and ActionCable.}
  s.description = %q{
                    Offload the rendering of slow view partials with ActiveJob and ActionCable to reduce page load times.
                  }
  s.homepage    = "https://github.com/danielwestendorf/get_schwifty"
  s.license     = "MIT"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "> 5"
  s.add_development_dependency "puma"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "redis"
end
