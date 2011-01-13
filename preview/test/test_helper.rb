require 'rubygems'
require 'test/unit'
require 'active_support'
require 'action_controller'

gem_root = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(gem_root, 'lib')
$LOAD_PATH << File.join(gem_root, 'lib', 'preview')

require File.join(gem_root, 'init.rb')
