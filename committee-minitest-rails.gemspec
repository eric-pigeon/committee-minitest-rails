# frozen_string_literal: true

require_relative "lib/committee/minitest/rails/version"

Gem::Specification.new do |spec|
  spec.name = "committee-minitest-rails"
  spec.version = Committee::Minitest::Rails::VERSION
  spec.authors = ["Eric Pigeon"]
  spec.email = ["eric.r.pigeon@gmail.com"]

  spec.summary = "Committee integration with Rails and Minitest"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["source_code_uri"] = "https://github.com/eric-pigeon/committee-minitest-rails"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
