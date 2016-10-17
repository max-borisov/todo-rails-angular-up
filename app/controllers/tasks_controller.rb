class TasksController < ApplicationController
  def create
    task = project.tasks.build(task_params)
    if task.save
      render json: { id: task.id, description: task.description,
                     completed: task.completed }, status: :created
    else
      render json: 'task could not be created', status: :bad_request
    end
  end

  def update
    if task.update(task_params)
      render json: { id: task.id, description: task.description,
                     completed: task.completed }, status: :ok
    else
      render json: 'task could not be updated', status: :bad_request
    end
  end

  def destroy
    if task.destroy
      render json: { id: task.id, description: task.description,
                     completed: task.completed }, status: :ok
    else
      render json: 'task could not be deleted', status: :unprocessable_entity
    end
  end

  def complete
    return render json: 'invalid task complete value',
                  status: :bad_request unless task_complete_param_valid?
    if task.update(completed: params[:complete])
      render json: { id: task.id, description: task.description,
                     completed: task.completed }, status: :ok
    else
      render json: 'task could not be completed', status: :unprocessable_entity
    end
  end

  private

  def project
    @_project ||= Project.find(params[:project_id])
  end

  def task
    @_task ||= project.tasks.find(params[:id])
  end

  def task_complete_param_valid?
    ['true', 'false'].include?(params[:complete])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
