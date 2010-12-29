require File.join(File.dirname(__FILE__), "lib", "preview")

# Ask ActiveRecord::Base to include code in the Preview::Models module
# Execute the ActiveRecord::Base.include method with Preview::Models arg
ActiveRecord::Base.send(:include, Preview::Models)

# Ask ActionController::Base to include Preivew::Controller::InstanceMethods
# The problem this solves is that before_filter methods should be available for the 
#   controller object to use during a request. Otherwise, the whole plugin functionality 
#   is being loaded only when the model class is loaded (in dev)
ActionController::Base.send(:include, Preview::Controllers::InstanceMethods)
