Mapped Attributes
=================

This gem allows to build ActiveRecord objects with alternative attribute naming. It is useful when you are importing ie. fetched data from XLS or parsed data from some website.

## Installation:
```gem install mapped_attributes```

or

```gem 'mapped_attributes'``` in your Gemfile

## Usage & Example
Include **MappedAttributes** module to model, for which you would like to use attribute mapping:
```ruby
class Project < ActiveRecord::Base
  include MappedAttributes

  has_many :tasks
  has_one :main_task, class_name: 'Task', order: 'priority ASC'
  accepts_nested_attributes_for :main_task
end

class Task < ActiveRecord::Base
  belongs_to :project
end
```

Define attributes mapping for certain model in your locales:
```yml
en:
  activerecord:
    mappings:
      project:
        subject: Project Name
        summary: Description
        priority: Importance
        start_at: 
          - Beginning
          - Start
        main_task_attributes:
          name: 
            - Task Name
            - Main Task
          description: Info
          due_date: Deadline
```

And finally set mapped attributes:
```ruby
    data = {
        'Project Name'  => 'Testing One',
        'Description'   => 'This project is just for test',
        'Importance'    => '3',
        'Beginning'     => '2013-01-01',
        'Task Name'     => 'Get a Job Done',
        'Info'          => 'Finalize first task',
        'Deadline'      => '2013-02-01'
        'Comments'      => 'Something something dark side'
    }
    project = Project.new
    project.set_mapped_attributes(data)
    project.save    
```

Also, you can list unmapped attributes:
```ruby
  project.get_unmapped_attributes
  # => ['Comments']
```

## Features
- you can map given data to object attributes
- you can provide custom mapping definition namespace: ```project.set_mapped_attributes(data, as: :custom_project)```
- you can define multiple mapping for a single attribute
- you can map attributes for the *has_one* and *belongs_to* relations if you are using *nested_attributes*

## Tests
Module is tested with minitest. To run it just execute ```rake```

## Credits
[Tomasz Borowski](http://tbprojects.pl)
