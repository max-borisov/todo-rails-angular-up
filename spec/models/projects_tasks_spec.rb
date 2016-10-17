require 'rails_helper'

describe ProjectsTasks do
  describe '.all' do
    it 'returnes projects with related tasks' do
      project = create(:project)
      create(:task, project: project)
      tasks = project.tasks.select(:id, :description, :completed)
      expected = [{ id: project.id, title: project.title,
                    tasks: [tasks.first] }]

      projects_tasks = ProjectsTasks.all

      expect(projects_tasks).to eq(expected)
    end
  end
end
