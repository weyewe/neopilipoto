class PicturesController < ApplicationController
  def new
    @project = Project.find_by_id( params[:project_id] )
    @pictures = @project.original_pictures  
    @new_picture = Picture.new
    
    
    add_breadcrumb "Select  project", 'select_project_to_be_managed_path'
    set_breadcrumb_for @project, 'new_project_picture_path' + "(#{@project.id})", 
          "Add Pictures for #{@project.title}"
  end
  
  
  def create
    
    @project = Project.find_by_id( params[:project_id] )
    new_picture = ""
    if not params[:transloadit].nil?
      new_picture = Picture.extract_uploads( 
        params[:transloadit][:results][":original".to_sym],
        params[:transloadit][:results][:resize_index], 
        params[:transloadit][:results][:resize_show], 
        params[:transloadit][:results][:resize_revision], 
        params, params[:transloadit][:uploads] )
    end 
      
    if params[:from_project_owner].nil?
      # it is from new picture page
   #   redirect_to new_project_submission_picture_path(@project_submission)
    else 
      # it is to create revision
      # only the owner that can upload images 
      redirect_to new_project_picture_url(@project)
    end
  end
  
  
=begin
  For Collaboration : client and collaborator 
=end

  def select_pictures_for_project
    @project = Project.find_by_id( params[:project_id])
    @pictures = @project.original_pictures
    
    add_breadcrumb "Select  project", 'select_project_for_collaboration_path'
    set_breadcrumb_for @project, 'select_pictures_for_project_path' + "(#{@project.id})", 
          "Select Pictures for #{@project.title}"
  end
  
  def execute_select_picture
    @project = Project.find_by_id( params[:membership_provider])
    @picture = Picture.find_by_id( params[:membership_consumer])
    
    if not params[:membership_decision].nil?
      @picture.set_selected_value( params[:membership_decision].to_i )
    end
    
    respond_to do |format|
      format.html {  redirect_to root_url } 
      format.js
    end
  end
  
=begin
  The real shit: uploading revision, adding comment, etc
=end
  def finalize_pictures_for_project
    @project  = Project.find_by_id( params[:project_id])
    @pictures = @project.selected_original_pictures
  end
  
  def show_picture_for_feedback
    @picture  = Picture.find_by_id(params[:picture_id])
    @original_picture = @picture.original_picture
    @all_revisions = @original_picture.revisions
    @root_comments = @picture.root_comments.order("created_at ASC")
    
    
  end
  
  
end
