class HomeController < ApplicationController
  
  # skip_before_filter :authenticate_user!, :only => [:dashboard]
  
  def dashboard
    if current_user.has_role?( :premium)
      redirect_to new_project_url 
      return 
    end
    
    if current_user.has_role?(:teacher)
      redirect_to select_subject_for_project_url 
      return
    end
    
    if current_user.has_role?(:student)
      redirect_to project_submissions_url 
      return
    end
  end
  
  
  
end
