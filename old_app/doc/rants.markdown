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

	