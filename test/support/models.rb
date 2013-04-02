class Project < ActiveRecord::Base
  has_many :tasks
  has_one :main_task, class_name: 'Task', order: 'priority ASC'
  accepts_nested_attributes_for :main_task

  validates_presence_of :subject
end

class Task < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :name
end