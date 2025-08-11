# frozen_string_literal: true

require_relative "lib/envsafe/version"

Gem::Specification.new do |spec|
  spec.name = "envsafe"
  spec.version = Envsafe::VERSION
  spec.authors = ["Kaiser Sakhi"]
  spec.email = ["mail@kaisersakhi.com"]

  spec.summary = "A simple CLI tool to back up, restore, and validate your .env files."

  spec.description = <<~DESC
    Envsafe is a standalone CLI utility for managing your .env files without project integration.

    Quickly back up your current environment, restore from any saved version, and compare your .env file
    against .env.example to catch missing or extra variables. Think of it as git stash for your .env.

    Core features:
      - Backup and restore .env files with optional tags
      - Pop the latest backup off the stack
      - Checkout any saved .env version or return to main
      - Validate .env vs .env.example
      - CLI-native — no Gemfile or code integration required

    Envsafe gives you safe, versioned control of your app’s environment variables — without the overhead.
  DESC

  spec.homepage = "https://github.com/kaisersakhi/envsafe"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kaisersakhi/envsafe"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ Gemfile .gitignore test/])
  #   end
  # end
  #
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      f.end_with?(".gem") ||
        f.start_with?(*%w[Gemfile .gitignore test/])
    end
  end


  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
