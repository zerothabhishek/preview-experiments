require 'preview/preview_processor'

module Preview
  module Controllers
    
    def self.included base 
      base.extend(Preview::Controllers::ClassMethods)
      Preview::Views.modify_form_helpers
    end
        
    module ClassMethods
      def previewable options={}        
        include Preview::Controllers::InstanceMethods        
        self.class_eval { cattr_accessor :preview }
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
  
  module Views
    def self.modify_form_helpers
      ActionView::Helpers::FormBuilder.class_eval do
        alias orig_submit submit        
        def submit value=nil, options={}
          options[:onclick] = "this.form.target='';return true;"
          orig_submit(value, options)
        end
      end
      ActionView::Helpers::FormBuilder.send(:include, Preview::Views::Helpers)
    end
    
    module Helpers        
      def preview options={}
        options[:id] = "preview"
    	  options[:name] = "preview"
    	  options[:onclick] = "this.form.target='_blank';return true;"
    	  orig_submit("preview", options)      
      end
    end    
  end
  
end