# Tell ruby to read the lib/preview.rb file
require 'preview'

# Ask ActiveRecord::Base to include code in the Preview module
# Execute the ActiveRecord::Base.include method with Preview arg
ActiveRecord::Base.send(:include, Preview)
