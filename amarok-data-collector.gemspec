$:.push File.expand_path('../lib', __FILE__)

require 'amarok-data-collector/version'

Gem::Specification.new do |s|
  s.name        = 'amarok-data-collector'
  s.version     = AmarokDataCollector::VERSION
  s.license     = 'MIT'
  s.author      = 'Viktor Lazarev'
  s.email       = 'taurus101v+amarok-stats@gmail.com'
  s.homepage    = 'https://github.com/gentoid/amarok-data-collector'
  s.summary     = 'Amarok data collector'
  s.description = "Collects data from Amarok's DB to get more interesting statistics"

  s.files       = `git ls-files -- lib/*`.split("\n") + %w(LICENSE README.md)
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename f }

  s.add_runtime_dependency 'thor'
end
