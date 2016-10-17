FactoryGirl.define do
  factory :task do
    project_id  project
    description Faker::Lorem.paragraph(1)
    completed   false
    position    1
  end
end
