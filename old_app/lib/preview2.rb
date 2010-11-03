module Preview2
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def previewable
      ActiveRecord::Base.logger.info "********** within previewable"
    end
  end

end