require 'test_helper'
require 'mocha'

class TestClass < ActionController::Base
end

class PreviewTest < ActiveSupport::TestCase

  test "the method previewable should be available to all controllers" do
  end
  
=begin
  test "previewable should include the Preview::Controllers::InstanceMethods module in the calling class" do
    # stub the other functionality
    TestClass.stubs(:class_eval).returns(true)
    TestClass.stubs(:before_filter).returns(true)
    TestClass.stubs(:preview=).returns(true)
    PreviewProcessor.stubs(:new).returns(true)
    
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
