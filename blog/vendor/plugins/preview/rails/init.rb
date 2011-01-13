require File.join(File.dirname(__FILE__), "lib", "preview")

# Ask ActiveRecord::Base to include code in the Preview::Models module
# Execute the ActiveRecord::Base.include method with Preview::Models arg
#ActiveRecord::Base.send(:include, Preview::Models)

# Ask ActionController::Base to include Preivew::Controller::InstanceMethods
ActionController::Base.send(:include, Preview::Controllers)
