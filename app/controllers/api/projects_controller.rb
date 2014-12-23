module Api
  class ProjectsController < ApiController
    respond_to :json

    def index
      render json: current_user.projects
    end
  
    def show
      project = current_user.projects.find_by(id: params[:id])
    
      if project
        render json: project, include: { tabs: { include: :stories } }
      else
        render json: ['the referenced project was not found'], status: 404
      end
    end
  
    def create
      project = current_user.projects.new(project_params)
      project.tabs.new([
        {name: 'current', ord: 1},
        {name: 'backlog', ord: 2},
        {name: 'icebox', ord: 3},
        {name: 'done', ord: 4}
      ])
    
      if project.save
        render json: project, include: :tabs
      else
        render json: project.errors.full_messages, status: :unprocessable_entity
      end
    end
  
    def update
      project = current_user.projects.find_by(id: params[:id])
    
      if project && project.update_attributes(project_params)
        render json: project
      else
        render json: project.errors.full_messages, status: :unprocessable_entity
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
      params.require(:project).permit(:title, :capacity)
    end
  end
end
