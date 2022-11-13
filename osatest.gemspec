require_relative 'lib/osatest/version'

Gem::Specification.new do |s|
  s.name          = "osatest"
  s.version       = Osatest::VERSION
  s.authors       = ["PhilippePerret"]
  s.email         = ["philippe.perret@yahoo.fr"]

  s.summary       = %q{MacOS CLI tests with osascript (for Terminal's apps)}
  s.description   = %q{MacOS CLI tests with osascript, for apps in Terminal (command line).}
  s.homepage      = "https://github.com/PhilippePerret/osatest"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.add_dependency 'yaml'
  s.add_dependency 'json'
  s.add_dependency 'osascript'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-color'
  s.add_development_dependency 'minitest/assertions'

  s.metadata["allowed_push_host"] = "https://github.com/PhilippePerret/osatest"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/PhilippePerret/osatest"
  s.metadata["changelog_uri"] = "https://github.com/PhilippePerret/osatest/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
