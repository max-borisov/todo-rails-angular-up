class ProjectsTasks
  def self.all
    projects = Project.select(:id, :title).includes(:tasks)
              .order(created_at: :asc).all
    projects.each_with_object([]) do |p, a|
      a << {
       id:    p.id,
       title: p.title,
       tasks: p.tasks.select(:id, :description, :completed)
      }
    end
  end
end
