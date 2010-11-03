require 'preview2'
include Preview2::ClassMethods
class Post < ActiveRecord::Base
  previewable
end
