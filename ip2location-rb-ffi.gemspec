Gem::Specification.new do |s|
  s.name        = "ip2location-rb-ffi"
  s.version     = "0.0.0"
  s.author      = "Peter Goncharov"
  s.email       = "peter@standalone.su"
  s.homepage    = ""
  s.summary     = "High level binding to ip2location lib using ffi"
  s.description = s.summary

  s.files        = Dir["{lib,spec}/**/*", "init.rb"] - ["Gemfile.lock"]
  s.require_path = "lib"

  s.add_dependency('ffi')

end
