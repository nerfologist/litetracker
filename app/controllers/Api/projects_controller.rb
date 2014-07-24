class Api::ProjectsController < ApplicationController
  before_action :require_signed_in!
  
  def index
    render json: current_user.projects
  end
  
  def show
    project = current_user.projects.find_by(id: params[:id])
    
    if project
      render json: project, include: :tabs
    else
      render json: ['the referenced project was not found'], status: 404
    end
  end
  
  def create
    project = current_user.projects.new(project_params)
    project.tabs.new([
      {name: 'icebox'},
      {name: 'backlog'},
      {name: 'current'},
      {name: 'done'}
    ])
    
    if project.save
      render json: project, include: :tabs
    else
      render json: ['unable to create project'], status: :unprocessable_entity
    end
  end
  
  def update
    project = current_user.projects.find_by(id: params[:id])
    
    if project && project.update_attributes(project_params)
      render json: project
    else
      render json: ['unable to update project'], status: :unprocessable_entity
    end
  end
  
  def destroy
    project = current_user.projects.find_by(id: params[:id])
    
    if project && project.destroy()
      render json: project
    else
      render json: ['unable to delete project'], status: :unprocessable_entity
    end
  end
  
  private

  def project_params
    params.require(:project).permit(:title, :velocity)
  end
end