# frozen_string_literal: true

require_relative "lib/websocket/echo/io/version"

Gem::Specification.new do |spec|
  spec.name = "websocket-echo-io"
  spec.version = Websocket::Echo::Io::VERSION
  spec.authors = ["Aleksandar N. Kostadinov"]
  spec.email = ["akostadi@redhat.com"]

  spec.summary = "WebSocket echo server with limits"
  spec.description = "A simple WebSocket echo server with data limits based on iodine"
  spec.homepage = "https://github.com/akostadinov/websocket-echo-io"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/akostadinov/websocket-echo-io"
  # spec.metadata["changelog_uri"] = "none"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .github Dockerfile Containerfile .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "iodine", "~> 0.7.55"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
