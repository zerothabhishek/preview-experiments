require 'preview/preview_processor'

module Preview
  module Controllers
    
    def self.included base 
      base.extend(Preview::Controllers::ClassMethods)
    end
    
    module ClassMethods

      # To be declared within a controller
      def previewable options={}
        
        include Preview::Controllers::InstanceMethods
        ActionView::Helpers::FormBuilder.send(:include, Preview::Views::Helpers)
        
        self.class_eval do
          cattr_accessor :preview
        end
        self.preview = PreviewProcessor.new(self, options)
        self.before_filter(:do_preview, {:only => self.preview.actions })        
      end
      
    end
    
    module InstanceMethods

      def do_preview
        return if params[:preview].blank?
        self.class.preview.process request
        render self.class.preview.template
      end

    end
    
  end
  
  module Models
  end
  
  module Views
    
    module Helpers    
      def preview options={}
    	  options[:name] = "preview"
    	  options[:onclick] = "this.form.target='_blank';return true;"
    	  submit("preview", options)      
      end
    end
    
  end
end