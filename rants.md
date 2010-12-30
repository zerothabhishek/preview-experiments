02nov2010

##code removed due to the new approach:
    if params[:preview]
      # save as preview
      # redirect to preview URL
      post_pre = Post.new(params[:post])
      # PreviewObjekt.create(:objekt => post_pre, :klass => 'Post', :idee => @post.id)
      # PreviewObjekt.create(:objekt => post_pre.to_yaml, :klass => 'Post', :idee => @post.id)
      #use Marshal serialization instead of yaml
      destroy_existing_preview(params[:id], "Post")
      marshalled_obj = Marshal.dump post_pre
      PreviewObjekt.create(:objekt => marshalled_obj, :idee => params[:id], :klass => "Post")
      redirect_to preview_post_path(@post)
      return
    end

    def preview
	    preview_obj = PreviewObjekt.find(params[:id])
	    #@post = Post.new preview_obj.objekt
	    #render "show"
	    #logger.info "post_pre: #{preview_obj.objekt}, #{preview_obj.objekt.class}"
    
	    #postYaml = preview_obj.objekt
	    #logger.info "post_obj: #{postYaml}, #{postYaml.class}"
    
	    # Using Marshal instead of yaml
	    postMarshal = Marshal.load(preview_obj.objekt)
	    logger.info "post_obj: #{postMarshal}, #{postMarshal.class}"
	    render :text => "preview"
	end
 	
	def destroy_existing_preview id, klass
    	pre_obj = PreviewObjekt.where("idee =?, klass =?",id,klass)
	    pre_obj.destroy unless pre_obj.blank?
    end
   
    if params[:preview]
      #destroy_existing_preview(params[:id], "Post")
      @post = Post.new(params[:post])
      render "show"
      return
      #marshalled_obj = Marshal.dump post_preview
      #PreviewObjekt.create(:objekt => marshalled_obj, :idee => nil, :klass => "Post")
      #redirect_to preview_post_path(@post)
      #return      
    end


## 27dec2010

basic setup:

    rails new blog
    cd blog; rm public/index.html
    rake db:create
	rails g scaffold post title:string content:text
	rake db:migrate

create the plugin

	 rails g plugin preview --with-generator


## 29dec2010

Tried one approach and abandoned it. Done with the new approach. Commits:-

0b6a6ed73fe135acd09263c34052033ece8fc861:

	Working now.
    Changed approach.
    Now: Controller based approach
    Earlier: Model based approach
    
    Check rants for todo

6dc606eb30ad1236a7e1eb4e846af632dbc586fc
	
	WIp
    
    Current approach has to be abandoned.
    Approach: the plugin functionality is triggered from the model. (model has the previe
    Problem Observed: In any (web) request, controller is loaded before the models. So so
    Concept: Trying to access controller from model is againsts MVC

    
## TODO-

### v0.1
- Y preview_tag or f.preview for views
- preview actions as parameters
- Y separate class to hold parameters and other data (model name, controller name)
- patch url/path helpers to not raise exceptions when object id is nil

### v0.2
- validations for preview
- handling paperclip attachments


hello
	

