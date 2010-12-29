module Preview
  module Controllers
    
    def self.included base 
      base.extend(Preview::Controllers::ClassMethods)
    end
    
    module ClassMethods

      # To be declared within a controller
      def previewable 
        include Preview::Controllers::InstanceMethods
        controllerKlass = self
        actions = [:create, :update]
        controllerKlass.before_filter(:do_preview, {:only => actions })
      end
      
    end
    
    module InstanceMethods

      def do_preview
        return if params[:preview].blank?
        controllerObj = self
        modelKlass = controllerObj.class.to_s.split("Controller").first.singularize.constantize
        modelObj = modelKlass.new(params[:post])
        modelObj.id = 0
        instanceVariable = ("@" + modelKlass.to_s.downcase).to_sym
        controllerObj.instance_variable_set(instanceVariable, modelObj)
        render "show"
        return
      end

    end
    
  end
  
  module Models
  end
  
  module Views
  end
end