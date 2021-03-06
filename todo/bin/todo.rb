#!/usr/bin/env ruby
# 1.9 adds realpath to resolve symlinks; 1.8 doesn't
# have this method, so we add it so we get resolved symlinks
# and compatibility
unless File.respond_to? :realpath
  class File #:nodoc:
    def self.realpath path
      return realpath(File.readlink(path)) if symlink?(path)
      path
    end
  end
end
$: << File.expand_path(File.dirname(File.realpath(__FILE__)) + '/../lib')
require 'rubygems'
require 'gli'
require 'todo_version'

include GLI

program_desc 'Kais automation box'

version Todo::VERSION

desc 'Describe some switch here'
switch [:s,:switch]

desc 'Describe some flag here'
default_value 'the default'
arg_name 'The name of the argument'
flag [:f,:flagname]

desc 'Describe new here'
arg_name 'Describe arguments to new here'
command :new do |c|
  c.desc 'Describe a switch to new'
  c.switch :s
  c.desc 'Describe a flag to new'
  
  c.default_value 'default'
  c.flag :f
  c.action do |global_options,options,args|
	puts "Global:"
	puts "-f  #{global_options[:f]}"
	puts "Command:"
	# Your command logic here
    puts "-f - #{options[:f] ? 'true' : 'false'}"
    puts "-p - #{options[:p]}" 
    puts "args -#{args.join(',')}"
    # If you have any errors, just raise them
    # raise "that command made no sense"
  end
end

desc 'Describe list here'
arg_name 'Describe arguments to list here'
command :list do |c|
	c.flag :s
  	c.action do |global_options,options,args|
  		puts "Global:"
		puts "-f - #{global_options[:f]}"
		puts "Command:"
		puts "-s - #{options[:s]}"
  end
end

desc 'Describe done here'
arg_name 'Describe arguments to done here'
command :done do |c|
  c.action do |global_options,options,args|
  	puts "Global:"
  	puts "-f - #{global_options[:f]}"
  end
end

pre do |global,command,options,args|
  # Pre logic here
  # Return true to proceed; false to abourt and not call the
  # chosen command
  # Use skips_pre before a command to skip this block
  # on that command only
  true
end

post do |global,command,options,args|
  # Post logic here
  # Use skips_post before a command to skip this
  # block on that command only
end

on_error do |exception|
  # Error logic here
  # return false to skip default error handling
  true
end

exit GLI.run(ARGV)
