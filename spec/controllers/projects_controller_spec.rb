require 'rails_helper'

describe ProjectsController do
  describe "GET #index" do
    it "json with projects and tasks" do
      project = create(:project)
      task = create(:task, project: project)
      expected = [{ id: project.id, title: project.title, tasks: [
        { id: task.id, description: task.description,
          completed: task.completed }] }]

      get :index

      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'POST #create' do
    it 'returnes status code 200 and project json' do
      post :create

      expected = { project: { id: 1, title: 'Project #1' } }
      expect(response.body).to eq(expected.to_json)
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT #update' do
    it 'returnes http code 200 and project json' do
      project = create(:project, title: 'Ruby project')
      expected = { project: { id: project.id, title: 'JS project' } }

      put :update, id: project.id, project: { title: 'JS project' }

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected.to_json)
    end

    it 'returnes json with errors and status code 400' do
      project = create(:project)

      put :update, id: project.id, project: { title: '' }

      expect(response).to have_http_status(400)
      expect(response.body).to include('invalid project title')
    end
  end

  describe 'DELETE #destroy' do
    it 'returnes http code 200 and deleted project' do
      project = create(:project, title: 'Ruby project')

      delete :destroy, id: project.id

      expect(response).to have_http_status(200)
    end

    it 'returnes error message and status code 422' do
      project = create(:project, title: 'Ruby project')
      allow_any_instance_of(Project).to receive(:destroy).and_return(false)

      delete :destroy, id: project.id

      expect(response).to have_http_status(422)
      expect(response.body).to include('project could not be deleted')
    end
  end
end
