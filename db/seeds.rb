seed_file = Rails.root.join('db', 'seeds.yml')

config = YAML::load_file(seed_file)

projects = config.fetch('projects')

Project.destroy_all
Todo.destroy_all

for item in projects do
  project = Project.create!(title: item.fetch('title'))

  todos = item.fetch('todos')

  for todo in todos do
    Todo.create(text: todo.fetch('text'),
                is_completed: todo.fetch('isCompleted') || false,
                project_id: project[:id])
  end
end
