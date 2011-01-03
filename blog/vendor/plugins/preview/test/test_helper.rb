require 'rubygems'
require 'test/unit'
require 'active_support'
require 'action_controller'

ROOT = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'preview')

require File.join(ROOT, 'lib', 'preview.rb')
