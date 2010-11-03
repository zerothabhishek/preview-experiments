# Preview
module Preview
  
  # This is callback method executed when this module (Preview) is included in another one (base)
  def self.included(base)
    # Ask the including module (base) to extend itself 
    # with the below defined ClassMethods module.
    # Therefore all the methods in the module will become class methods for base
    # and its derived classes. 
    # here base is ActiveRecord::Base, all models will get the ClassMethods
    base.extend(ClassMethods) 
  end
  
  # class methods that can be called by classes declaratively
  # here ActiveRecord::Base has been extended with the ClassMethods, so 
  # model classes can use the previewable declaration
  module ClassMethods
    def previewable
      include Preview::InstanceMethods
      
      ActiveRecord::Base.logger.info "********** within previewable"
      # 1. get the corresponding controller
      # 2. add a before filter to the controller update and create methods
    end
  end
  
  # methods that need to be used by objects of a class
  # that has called the 'previewable' class method
  # here it is the model class, so the below mothods can be called by model objects
  module InstanceMethods
  end

end

