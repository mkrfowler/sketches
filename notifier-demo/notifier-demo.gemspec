# frozen_string_literal: true

require_relative "lib/notifier/demo/version"

Gem::Specification.new do |spec|
  spec.name = "notifier-demo"
  spec.version = Notifier::Demo::VERSION
  spec.authors = ["Michael Fowler"]
  spec.email = ["mkrfowler@gmail.com"]

  spec.summary = "A small demonstration of using the ActiveSupport::Notifications API"
  spec.description = "It is not a useful block of code."
  spec.homepage = "https://example.com"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mkrfowler/sketches/notifier-demo"
  spec.metadata["changelog_uri"] = "https://github.com/mkrfowler/sketches/notifier-demo/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 7.0.4"
end
