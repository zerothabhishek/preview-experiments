# Tell ruby to read the lib/preview.rb file
require 'preview'

# Ask ActiveRecord::Base to include code in the Preview::Models module
# Execute the ActiveRecord::Base.include method with Preview::Models arg
ActiveRecord::Base.send(:include, Preview::Models)

# Ask ActionController::Base to include code in the Preview::Controllers module
# Execute the ActionController::Base.include method with Preview::Models arg
ActionController::Base.send(:include, Preview::Controllers)