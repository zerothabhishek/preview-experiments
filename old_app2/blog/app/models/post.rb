class Post < ActiveRecord::Base
  # e.g - 
  #  preview_validatinos :none    # apply no validations, default choice
  #  preview_validations :all     # apply all validations mentioned in the model
  #  preview_validations :title         # apply all validations related to the :title attribute
  #  preview_validations do             # specify validations to be applied, could be a copy paste 
  #    validate_presence_of :content    # of the model validations or new ones
  #    validate_length_of :title, :maximum => 200
  #  end
  preview_validations
end
