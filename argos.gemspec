# -*- encoding: utf-8 -*-
require File.expand_path('../lib/argos/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Derek Lindahl"]
  gem.email         = ["dlindahl@customink.com"]
  gem.description   = %q{WIP: An MP3 tagger and renamer}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/dlindahl/argos"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "argos"
  gem.require_paths = ["lib"]
  gem.version       = Argos::VERSION

  gem.add_dependency 'earworm', '~> 0.0.2'
end
