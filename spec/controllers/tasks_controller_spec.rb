require 'rails_helper'

describe TasksController do
  describe 'POST #create' do
    it 'returnes http code 201 and task json' do
      project = create(:project)

      post :create, project_id: project.id,
                    task: { description: 'Task description' }

      expected = { id: project.tasks.first.id,
                   description: 'Task description', completed: false }
      expect(response).to have_http_status(201)
      expect(response.body).to eq(expected.to_json)
    end

    it 'returnes http code 400 and error message' do
      project = create(:project)

      post :create, project_id: project.id, task: { description: '' }

      expect(response).to have_http_status(400)
      expect(response.body).to eq('task could not be created')
    end
  end

  describe 'PUT #update' do
    let!(:project) { create(:project) }
    let!(:task) { create(:task, project: project) }

    it 'returnes http status code 200 and task json' do
      expected = { id: task.id, description: 'New task',
                   completed: task.completed }

      put :update, id: task.id, project_id: project.to_param,
                   task: { description: 'New task' }

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected.to_json)
    end

    it 'returnes http status code 400 and error message' do
      put :update, id: task.id, project_id: project.id,
                   task: { description: '' }

      expect(response).to have_http_status(400)
      expect(response.body).to eq('task could not be updated')
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project) }
    let!(:task) { create(:task, project: project) }

    it 'returnes http status code 200 and taks json' do
      expected = { id: task.id, description: task.description,
                   completed: task.completed }

      put :destroy, id: task.id, project_id: project.id

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected.to_json)
    end

    it 'returnes http code 400 and error message' do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)

      put :destroy, id: task.id, project_id: project.id

      expect(response).to have_http_status(422)
      expect(response.body).to eq('task could not be deleted')
    end
  end

  describe 'PUT #complete' do
    let!(:project) { create(:project) }
    let!(:task) { create(:task, project: project) }

    it 'returnes http status code 400 and error message for invalid param' do
      put :complete, id: task.id, project_id: project.id, complete: '1'

      expect(response).to have_http_status(400)
      expect(response.body).to eq('invalid task complete value')
    end

    it 'returnes http status code 200 and task json' do
      expected = { id: task.id, description: task.description,
                   completed: true }

      put :complete, id: task.id, project_id: project.id, complete: 'true'

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected.to_json)
    end

    it 'returnes http status code 422 and error message' do
      allow_any_instance_of(Task).to receive(:update).and_return(false)

      put :complete, id: task.id, project_id: project.id, complete: 'true'

      expect(response).to have_http_status(422)
      expect(response.body).to eq('task could not be completed')
    end
  end
end
