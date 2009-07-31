# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sif}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors =  ["Fabian Streitel"]
  s.date = %q{2009-08-03}
  s.description = %q{Sif is a commandline parser that operates on the same principle as Yehuda Katz's Thor.'}
  s.email = %q{karottenreibe@gmail.com}
  s.files = ["History.txt", "README.txt", "LICENSE.txt", "sif.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/karottenreibe/sif}
  s.rubygems_version = %q{1.3.0}
  s.summary = s.description

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ohash>)
    else
      s.add_dependency(%q<ohash>)
    end
  else
    s.add_dependency(%q<ohash>)
  end
end

