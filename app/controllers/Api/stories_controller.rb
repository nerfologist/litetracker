module Api
  class StoriesController < ApiController
    def index
      project = current_user.projects.find_by(id: params[:project_id])

      if project
        render json: project.stories
      else
        render json: ['project not found'], status: 404
      end
    end
  
    def create
      project = current_user.projects.find_by(id: params[:project_id])
      return render json: ['project not found'], status: 404 unless project
    
      tab = project.tabs.find_by(id: story_params[:tab_id])
      return render json: ['tab not found'], status: 404 unless tab
    
      story = tab.stories.new(story_params)

      if story.save
        render json: story
      else
        render json: ['could not create story'], status: :unprocessable_entity
      end
    end

    def show
      project = current_user.projects.find_by(id: params[:project_id])

      if project && (story = project.stories.find_by(id: params[:id]))
        render json: story
      else
        render json: ['story not found'], status: 404
      end
    end

    def update
      project = current_user.projects.find_by(id: params[:project_id])
      return render json: ['project not found'], status: 404 unless project

      story = project.stories.find_by(id: params[:id])
      return render json: ['story not found'], status: 404 unless story

      if story.update_attributes(story_params)
        render json: story
      else
        render json: ['unable to update story'], status: :unprocessable_entity
      end
    end

    def destroy
      project = current_user.projects.find_by(id: params[:project_id])
      return render json: ['project not found'], status: 404 unless project

      story = project.stories.find_by(id: params[:id])
      return render json: ['story not found'], status: 404 unless story

      if story.destroy
        render json: story
      else
        render json: ['unable to delete story'], status: :unprocessable_entity
      end
    end

    private
    def story_params
      params.require(:story).permit(:tab_id, :title, :type, :points, :state)
    end
  end
end