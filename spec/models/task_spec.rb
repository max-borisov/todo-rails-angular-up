require 'rails_helper'

describe Task do
  it { should belong_to(:project) }

  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(255) }
  it { should validate_inclusion_of(:completed).in_array([true, false]) }

  # describe '.sort_tasks' do
  #   before do
  #     project = create(:project)
  #     @task1 = create(:task, project: project, position: 1)
  #     @task2 = create(:task, project: project, position: 2)
  #     Task.sort_tasks([@task2.id, @task1.id])
  #   end

  #   it 'updates tasks position' do
  #     expect(Task.first.position).to eq(2)
  #     expect(Task.last.position).to eq(1)
  #   end
  # end
end
