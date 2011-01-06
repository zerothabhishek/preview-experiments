require 'test_helper'
require 'mocha'

class FoosController < ActionController::Base ; end
class Foo; end
class FakeRequest
  def env
    fc = FoosController.new
    {"action_controller.instance" => fc}
  end
end

class PreviewProcessorTest < ActiveSupport::TestCase
  
  test "initialize should initialize the attributes controller, modelKlass, actions and template" do
    p = Preview::PreviewProcessor.new FoosController
    assert FoosController, p.controller
    assert Foo, p.modelKlass
    assert [:create, :update], p.actions
    assert "show", p.template
  end
  
  test "process should set an instance variable by the name of the model for the controller instance" do
    p = Preview::PreviewProcessor.new FoosController
    request = FakeRequest.new
    FoosController.any_instance.stubs(:params).returns(:Foo => {})
    Foo.stubs(:new).returns(Foo.new)
    
    p.process request
    assert p.instance_variable_defined?(:@foo)
  end
  
end  