class ProjectsController < ApplicationController
  def new 
    @project= Project.new
    @projects = current_user.projects 
    
  end
  
  def create
    @project = Project.new( params[:project] )
    
    
    if @project.save
      @project.add_owner( current_user )
      redirect_to new_project_url
    end
  end
  
  
  def select_project_to_invite_client
    select_project_to_invite_user
    add_breadcrumb "Pick the project", 'root_path'
  end
  
  def select_project_to_invite_collaborator
    select_project_to_invite_user
  end
  
  def invite_client_for_project
    invite_user_for_project(params)
    
    add_breadcrumb "Pick the project", 'select_project_to_invite_client_path'
    set_breadcrumb_for @project, 'invite_client_for_project_path' + "(#{@project.id})", 
          "Invite Client for #{@project.title}"
  end
  
  def execute_invite_client
    @project = Project.find_by_id( params[:project_id] )
    
    if params[:user][:email].nil?
      redirect_to invite_client_for_project_url(@project)
      return
    end
    
    @new_user = @project.invite_project_collaborator(:client, params[:user][:email])
    
    if  @new_user.valid?
      redirect_to  invite_client_for_project_url(@project)
    end
    
    add_breadcrumb "Pick the project", 'select_project_to_invite_client_path'
    set_breadcrumb_for @project, 'invite_client_for_project_path' + "(#{@project.id})", 
          "Invite Client for #{@project.title}"
          
          
  end
  
  def invite_collaborator_for_project
    invite_user_for_project
  end
  
  
  protected
  
  def invite_user_for_project(params )
    @project = Project.find_by_id( params[:project_id])
    @new_user = User.new 
  end
  
  def select_project_to_invite_user 
    @projects = current_user.projects 
  end
  
  
end
