# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epl_cli_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "epl_cli_gem"
  spec.version       = EplCliGem::VERSION
  spec.authors       = ["J Ilustrisimo"]
  spec.email         = ["j.ilustrisimo@gmail.com"]

  spec.summary       = "English Premier League"
  spec.description   = "Provides current EPL team rankings and info"
  spec.homepage      = "https://github.com/jilustrisimo/epl-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.executables << 'epl'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~>0.10.4"

  spec.add_dependency "nokogiri", "~>1.7"
  spec.add_dependency "terminal-table", "~>1.7"
  spec.add_dependency "colorize", "~>0.8"
end
