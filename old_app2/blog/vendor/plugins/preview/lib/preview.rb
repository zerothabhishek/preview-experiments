# Preview
module Preview
  
  mattr_accessor :controllerName      # the controller's name as string
  mattr_accessor :modelName           # the model's name as string
  mattr_accessor :viewName            # the view's name as string
    
  module Controllers

    # This is callback method executed when this module (Preview) is included in another one (base)
    def self.included(base)
      # Ask the including module (base) to extend itself 
      # with the below defined ClassMethods module.
      # Therefore all the methods in the module will become class methods for base
      # and its derived classes. 
      # here base is ActionController::Base, all controllers will get the ClassMethods
      base.extend(ClassMethods)
    end

    # class methods that can be called by classes declaratively
    # here ActionController::Base has been extended with the ClassMethods, so 
    # controller classes can use the previewable declaration    
    module ClassMethods
            
      # To be declared within the controller as -
      #  previewable :actions => [:create, :update, ...], :view => "show"
      # The declaration is method call to class method previewable, and all the 
      # previous code is done to make the method available to the class
      def previewable options={}
        include Preview::Controllers::InstanceMethods
        
        ActiveRecord::Base.logger.info "********** within previewable 1, #{options[:actions]}"

        actions = options[:actions] || "[:create, :update]"
        #self.class_eval "before_filter :do_preview, :only => #{actions} "
        self.send(:before_filter, [:do_preview, {:only => actions}])
        
        ActiveRecord::Base.logger.info "********** within previewable 2"
        
        ApplicationHelper.module_eval %q{
          include Preview::Helpers
        }
        
        ActiveRecord::Base.logger.info "********** within previewable 3"

        Preview.controllerName = self.to_s
        Preview.modelName = Preview.controllerName.split("sController").first
        Preview.viewName = options[:view] || "show"
        
      end
      
    end
    
    # methods that need to be used by objects of a class
    # that has called the 'previewable' class method
    # here it is the controller class, so the below mothods can be called by controller objects
    module InstanceMethods
      
      def do_preview
        return if params[:preview].blank?
        
        modelClass = Preview.modelName.constantize
        modelObj = modelClass.new(params[Preview.modelName.downcase.to_sym])
        modelObj.id = 0           # Dirty hack: the object needs an id so that url/path helpers can work. Give it an unused id
        template_name = Preview.viewName
        
        if defined? modelobj.preview_is_valid? and !modelObj.preview_is_valid?
          # set error flashes
        end
        
        modelObjInstanceVarName = Preview.modelName.downcase
        eval "@#{modelObjInstanceVarName} = modelObj"
        render template_name
        return
      end
      
    end
      
  end
  
  module Models
    
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
      def preview_validations
        include Preview::Models::InstanceMethods
        ActiveRecord::Base.logger.info "********** within preview_validations"
      end
    end

    # methods that need to be used by objects of a class
    # that has called the 'previewable' class method
    # here it is the model class, so the below mothods can be called by model objects
    module InstanceMethods
      def preview_is_valid?
        true
      end
    end

  end

  module Helpers
  
    # returns the html for the preview button
    def preview_tag options={}
      options[:name] = "preview"
      options[:onclick] = "this.form.target='_blank';return true;"
      submit_tag("preview", options)
    end
  
  end
  
end

