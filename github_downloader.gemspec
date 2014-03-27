# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_downloader/version'

Gem::Specification.new do |spec|
  spec.name = "github_downloader"
  spec.version = GithubDownloader::VERSION
  spec.authors = ["Nacho Lopez"]
  spec.email = ["nacho@nlopez.io"]
  spec.summary = %q{Downloader for GitHub projects for users or organizations}
  spec.description = %q{With this gem you can bulk download all the repositories from a single user or an organization, archived in zip files.}
  spec.homepage = "http://github.com/mrmans0n/github-downloader"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.executables << "ghdl"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"

  spec.required_ruby_version = ">= 1.9.2"

  spec.add_dependency "github_api", "~> 0.11"
end
