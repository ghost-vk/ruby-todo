class TodoSerializer < ActiveModel::Serializer
  attributes :id, :text, :is_completed
  belongs_to :project
end
