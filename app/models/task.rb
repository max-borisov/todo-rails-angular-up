class Task < ActiveRecord::Base
  belongs_to :project

  validates :description, presence: true, length: { maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }

  # def self.sort_tasks(tasks)
  #   tasks_positions = {}
  #   tasks.each_index { |index| tasks_positions[tasks[index]] = { 'position': index + 1 } }
  #   update(tasks_positions.keys, tasks_positions.values)
  # end
end
