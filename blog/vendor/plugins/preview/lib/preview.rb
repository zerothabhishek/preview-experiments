# Preview

module Preview
  
  module Models   
    # method called when Preview::Models is included within ActiveRecord::Base (see init.rb)
    # _base_ is ActiveRecord::Base
    def self.included base
      base.extend(ClassMethods)    # for adding class method definitions to _base_ class. similar to class_eval
    end
    
    module ClassMethods     
      # method added as class method to ActiveRecord:Base (via base.extend in Preview::Models, self.included) 
      # child classes of ActiveRecord:Base (models) can call this method declaratively, it will be invoked when the class is loaded
      def previewable
        #debugger
        controllerKlass = self.to_controller
        controllerKlass.send(:before_filter, :foo)
        #controllerKlass.send(:before_filter, :do_preview)
        #ApplicationHelper.send(:include, Preview::Views::Helpers)
        #ActiveRecord::Base.logger.info "=======>within #{self}.previewable"        
      end    
      def to_controller
        modelKlass = self
        (modelKlass.to_s.pluralize.capitalize + "Controller").constantize
      end      
    end
  end
  
  module Controllers
    module InstanceMethods  
      
      def self.included mod
        msg = "======> Preview::Controllers::InstanceMethods included by #{mod.to_s}"
        p msg
        ActiveRecord::Base.logger.info msg
      end
      
      def foo
        p "hello from foo"
        ActiveRecord::Base.logger.info "hello from foo"
      end
    
      def do_preview
        return if params[:preview].blank?
        modelObj = self.class.to_model.new(params)    # create the new model object with the params supplied
        modelObj.id = 0                               # for the url helpers
        modelInstanceVariableName = "@#{modelObj.class.to_s.downcase}".to_sym
        self.instance_variable_set(modelInstanceVariableName, modelObj)         # set the instance variable @model to modelObj
        render "show"                                 # render the show template
        return
      end
    
      def to_model
        controllerKlass = self.class
        controllerKlass.to_s.split("Controller").first.singularize.constantize
      end
      
    end    
  end
  
  module Views
    module Helpers
      
      # returns the html for the preview button
      def preview_tag options={}
        options[:name] = "preview"
        options[:onclick] = "this.form.target='_blank';return true;"
        submit_tag("preview", options)
      end
      
    end
  end
  
  class ControllerNotFoundError < StandardError
  end
    
end
