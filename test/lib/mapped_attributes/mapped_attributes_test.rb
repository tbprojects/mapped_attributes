require_relative '../../test_helper'

describe MappedAttributes do

  Project.send(:include, MappedAttributes)

  it "responds to set_mapped_attributes" do
    Project.new.respond_to?(:set_mapped_attributes).must_equal true
  end

  it "responds to get_unmapped_attributes" do
    Project.new.respond_to?(:get_unmapped_attributes).must_equal true
  end

  it "sets and returns mapped attributes" do
    data = {
        'Project Name'  => 'Testing One',
        'Description'   => 'This project is just for test',
        'Importance'    => '3',
        'Beginning'     => '2013-01-01',
        'Task Name'     => 'Get a Job Done',
        'Info'          => 'Finalize first task',
        'Deadline'      => '2013-02-01'
    }
    project = Project.new
    project.set_mapped_attributes(data)
    project.save
    project.persisted?.must_equal true
    project.subject.must_equal data['Project Name']
    project.summary.must_equal data['Description']
    project.priority.to_s.must_equal data['Importance']
    project.start_at.to_s(:db).must_equal data['Beginning']

    task = project.main_task
    task.persisted?.must_equal true
    task.name.must_equal data['Task Name']
    task.description.must_equal data['Info']
    task.due_date.to_s(:db).must_equal data['Deadline']
  end

  it "remembers unmapped attributes" do
    data = {
        'Project Name'  => 'Testing One',
        'Task Name'     => 'Get a Job Done',
        'Comments'      => 'Additional Text'
    }
    project = Project.new
    project.set_mapped_attributes(data)
    project.save
    project.persisted?.must_equal true
    project.get_unmapped_attributes.must_equal ['Comments']
  end

  it "allows to give provide custom mapping namespace" do
    data = {
        'Project Label' => 'Testing One',
        'Main Task'     => 'Get a Job Done',
    }
    project = Project.new
    project.set_mapped_attributes(data, as: :custom_project)
    project.save
    project.persisted?.must_equal true
    project.subject.must_equal data['Project Label']

    task = project.main_task
    task.persisted?.must_equal true
    task.name.must_equal data['Main Task']
  end

  it 'allows to define multiple mappings for single attribute' do
    data = {
        'Work Name'     => 'Testing One',
        'Subwork Name'  => 'Get a Job Done',
    }
    project = Project.new
    project.set_mapped_attributes(data, as: :multiple_mapping_project)
    project.save
    project.persisted?.must_equal true
    project.subject.must_equal data['Work Name']

    task = project.main_task
    task.persisted?.must_equal true
    task.name.must_equal data['Subwork Name']
  end

  it "raises error when mapping is not defined" do
    data = {
        'Project Name'  => 'Testing One',
        'Task Name'     => 'Get a Job Done'
    }
    project = Project.new
    proc {project.set_mapped_attributes(data, as: :not_existing_mapping)}.must_raise RuntimeError
  end
end