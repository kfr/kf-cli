# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','todo_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'todo'
  s.version = Todo::VERSION
  s.author = 'Kai Fredriksen'
  s.email = 'kai@titanit.no'
  s.homepage = 'http://www.titanit.no'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Alle mine daglige gjøremål skal automatiseres og vil ligge som kommandoer i TODO'
# Add your other files here if you make them
  s.files = %w(bin/todo)
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','todo.rdoc']
  s.rdoc_options << '--title' << 'todo' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'todo'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
end
