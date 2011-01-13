module Preview
  class PreviewProcessor
    
    attr_accessor :controller, :modelKlass, :actions, :template
    
    def initialize controllerKlass, options={}
      @controller = controllerKlass                         # the class name of controller
      @modelKlass = model_for @controllerName               # the class name of the corresponding model
      @actions = options[:actions] || [:create, :update]
      @template = options[:template] || "show"
    end

    def process request
      controllerInstance = request.env["action_controller.instance"]
      params = controllerInstance.params
      
      data = params[@modelKlass.to_s.downcase]      
      modelObj = @modelKlass.new(data)
      modelObj.id = params[:id].to_i
      
      instanceVariable = ("@" + @modelKlass.to_s.downcase).to_sym
      controllerInstance.instance_variable_set(instanceVariable, modelObj)
    end
    
    private 
    
    def model_for controllerKlass
      @controller.to_s.split("Controller").first.singularize.constantize
    end
    
    def controller_from request
      controllerName = request.parameters[:controller]                          # "posts"
      controllerKlass = (controllerName.capitalize +"Controller").constantize   # "posts"->"Posts"->"PostsController"->PostsController
      # controllerKlass = request.env["action_controller.instance"].class
      return controllerKlass
    end
  
  end
end