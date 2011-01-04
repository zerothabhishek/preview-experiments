require 'test_helper'
require 'mocha'

class TestController < ActionController::Base ; end

class PreviewTest < ActiveSupport::TestCase
  
  def setup
  end

  test "the class method _previewable_ should be available to all controllers" do
    assert ActionController::Base.respond_to?"previewable"
  end

  test "a controller using _previewable_ declaration should get the *do_preview* instance method" do
    TestController.previewable
    assert TestController.method_defined? :do_preview
  end
  
  test "a controller using _previewable_ declaration should get the class attribute _preview_" do
    TestController.previewable
    assert TestController.class_variable_defined?(:@@preview)
    assert TestController.respond_to? :preview
    assert TestController.respond_to? :preview=
  end
  
  test "a controller using _previewable_ should have the preview attribute holding a PreviewProcessor object" do
    TestController.previewable
    assert_equal Preview::PreviewProcessor, TestController.preview.class
  end
  
  test "controller using _previewable_ should get a do_preview before_filter for the specified actions" do
    TestController.expects(:before_filter).with(:do_preview, {:only => :create})
    TestController.previewable :actions=>:create
  end
  
  test "do_preview should not process preview if the preview parameter is not set" do
    TestController.any_instance.stubs(:params).returns({:preview => nil})
    Preview::PreviewProcessor.expects(:process).never
    TestController.previewable
    assert_equal nil, TestController.new.do_preview
  end
  
  test "do_preview should process preview if preview parameter is set" do
    TestController.any_instance.stubs(:params).returns({:preview => true})
    TestController.any_instance.stubs(:request).returns("requestHash")
    Preview::PreviewProcessor.any_instance.stubs(:process).returns(true)
    
    TestController.any_instance.expects(:render).with("show").returns(true)
    Preview::PreviewProcessor.any_instance.expects(:process).with("requestHash").once
    
    TestController.previewable  
    TestController.new.do_preview  
  end
  
=begin  
  test "previewable should include the Preview::Controllers::InstanceMethods module in the calling class" do
    # stub the other functionality
    TestClass.stubs(:class_eval).returns(true)
    TestClass.stubs(:before_filter).returns(true)
    TestClass.stubs(:preview=).returns(true)
    Preview::PreviewProcessor.stubs(:new).returns(true)
    
    TestClass.expects(:include).with(Preview::Controllers::InstanceMethods).once
    TestClass.previewable
  end

  test "previewable should add the preview attribute to the calling class" do
    # stub the other functionality
    TestClass.stubs(:before_filter).returns(true)
    TestClass.stubs(:include).returns(true)
    PreviewProcessor.stubs(:new).returns("foo")
    
    TestClass.previewable
    assert_equal "foo", TestClass.preview
    assert_nothing_raised(NoMethodError){  TestClass.preview = "hello" }  
  end
  
  test "previewable should assign a PreviewProcessor object to the class attribute preview " do
    # stub out the other functionality
    TestClass.stubs(:before_filter).returns(true)
    TestClass.stubs(:include).returns(true)
    PreviewProcessor.stubs(:new).returns("preview_processor_obj")
    
    TestClass.previewable
    assert_equal "preview_processor_obj", TestClass.preview
  end
  
  test "previewable should invoke the before_filter for the calling class" do
    # stub the other functionality
    TestClass.stubs(:include).returns(true)
    TestClass.stubs(:class_eval).returns(true)
    TestClass.stubs(:preview=).returns(true)
    PreviewProcessor.stubs(:new).returns(true)
    
    TestClass.expects(:before_filter).with(:do_preview).once
    TestClass.previewable
  end
=end
  
end
