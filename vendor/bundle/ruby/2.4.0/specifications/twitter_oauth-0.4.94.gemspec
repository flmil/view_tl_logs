# -*- encoding: utf-8 -*-
# stub: twitter_oauth 0.4.94 ruby lib

Gem::Specification.new do |s|
  s.name = "twitter_oauth".freeze
  s.version = "0.4.94"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Richard Taylor".freeze]
  s.date = "2013-06-12"
  s.description = "twitter_oauth is a Ruby client for the Twitter API using OAuth.".freeze
  s.email = "moomerman@gmail.com".freeze
  s.homepage = "http://github.com/moomerman/twitter_oauth".freeze
  s.rdoc_options = ["--inline-source".freeze, "--charset=UTF-8".freeze]
  s.rubyforge_project = "twitter_oauth".freeze
  s.rubygems_version = "2.7.3".freeze
  s.summary = "twitter_oauth is a Ruby client for the Twitter API using OAuth.".freeze

  s.installed_by_version = "2.7.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0.4.7"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 1.8.0"])
      s.add_runtime_dependency(%q<mime-types>.freeze, [">= 1.16"])
      s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    else
      s.add_dependency(%q<oauth>.freeze, [">= 0.4.7"])
      s.add_dependency(%q<json>.freeze, [">= 1.8.0"])
      s.add_dependency(%q<mime-types>.freeze, [">= 1.16"])
      s.add_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>.freeze, [">= 0.4.7"])
    s.add_dependency(%q<json>.freeze, [">= 1.8.0"])
    s.add_dependency(%q<mime-types>.freeze, [">= 1.16"])
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
  end
end
