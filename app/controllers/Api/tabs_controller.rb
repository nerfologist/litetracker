module Api
  class TabsController < ApiController
    def index
      project = current_user.projects.find_by(id: params[:project_id])
    
      if project
        render json: project.tabs, include: :stories
      else
        render json: ['project not found'], status: 404
      end
    end
  
    def create
      project = current_user.projects.find_by(id: params[:project_id])

      if !project
        render json: ['project not found'], status: 404
      elsif tab = project.tabs.create(tab_params)
        render json: tab
      else
        render json: ['unable to create tab'], status: :unprocessable_entity
      end
    end

    def show
      project = current_user.projects.find_by(id: params[:project_id])

      if project && (tab = project.tabs.find_by(id: params[:id]))
        render json: tab
      else
        render json: ['tab not found'], status: :unprocessable_entity
      end
    end

    def update
      project = current_user.projects.find_by(id: params[:project_id])
    
      if ! project
        render json: ['project not found'], status: 404
      else
        tab = project.tabs.find_by(id: params[:id])
        if tab && tab.update_attributes(tab_params)
          render json: tab
        else
          render json: ['unable to update tab'], status: :unprocessable_entity
        end
      end
    end

    def destroy
      project = current_user.projects.find_by(id: params[:project_id])
    
      if project && (tab = project.tabs.find_by(id: params[:id])) && tab.destroy
        render json: tab
      else
        render json: ['unable to destroy tab'], status: :unprocessable_entity
      end
    end

    private

    def tab_params
      params.require(:tab).permit(:name)
    end
  end
end