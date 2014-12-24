module Api
  class ProjectsController < ApiController
    def index
      respond_with current_user.projects
    end
  
    def show
      project = current_user.projects.find_by(id: params[:id])
    
      if project
        respond_with project, include: { tabs: { include: :stories } }
      else
        respond_with ['the referenced project was not found'], status: 404
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
        respond_with project, include: :tabs
      else
        respond_with project.errors.full_messages, status: :unprocessable_entity
      end
    end
  
    def update
      project = current_user.projects.find_by(id: params[:id])
    
      if project && project.update_attributes(project_params)
        respond_with project
      else
        respond_with project.errors.full_messages, status: :unprocessable_entity
      end
    end
  
    def destroy
      project = current_user.projects.find_by(id: params[:id])
    
      if project && project.destroy()
        respond_with project
      else
        respond_with ['unable to delete project'], status: :unprocessable_entity
      end
    end
  
    private

    def project_params
      params.require(:project).permit(:title, :capacity)
    end
  end
end
