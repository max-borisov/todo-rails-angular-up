class ProjectsController < ApplicationController
  def index
    projects = ProjectsTasks.all
    render json: projects
  end

  def create
    project = Project.create(title: "Project ##{Project.count + 1}")
    render json: { project: { id: project.id, title: project.title } },
           status: :created
  end

  def update
    if project.update(project_params)
      render json: { project: { id: project.id, title: project.title } },
             status: :ok
    else
      render json: 'invalid project title', status: :bad_request
    end
  end

  def destroy
    if project.destroy
      render json: project, status: :ok
    else
      render json: 'project could not be deleted', status: :unprocessable_entity
    end
  end

  private

  def project
    @_project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
