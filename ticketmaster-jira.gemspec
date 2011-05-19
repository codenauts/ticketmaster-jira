# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ticketmaster-jira}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell"]
  s.date = %q{2011-05-18}
  s.description = %q{Interact with Atlassian JIRA ticketing system from ruby}
  s.email = ["cowboyd@thefrontside.net"]
  s.homepage = %q{http://github.com/cowboyd/ticketmaster-jira}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.1}
  s.summary = %q{TicketMaster binding for JIRA}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ticketmaster>, [">= 0"])
      s.add_runtime_dependency(%q<jira4r-jh>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<ticketmaster>, [">= 0"])
      s.add_dependency(%q<jira4r-jh>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<ticketmaster>, [">= 0"])
    s.add_dependency(%q<jira4r-jh>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end

