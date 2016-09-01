require 'rails_helper'
RSpec.describe Task, type: :model do

  it "is a thing" do
    expect{Task.new}.to_not raise_error
  end

  it "has a title and description" do
    task = Task.new(title: "shopping", description: "go shopping", done:true)

  end

  it 'can list all tasks that are done' do
    task = Task.new(title: "shopping", description: "go shopping", done:true)
    task.save
    task2 = Task.new(title: "laundry", description: "go shopping")
    task2.save
    # task_find = Task.all.find_by_done(true)
    expect(Task.all.pluck(:done)).to eq [true, nil]
  end

  it 'can list all tasks that are not done' do
    task = Task.new(title: "shopping", description: "go shopping", done:false)
    task.save
    task2 = Task.new(title: "laundry", description: "go shopping")
    task2.save
    # task_find = Task.all.find_by_done(true)
    expect(Task.all.pluck(:done)).to eq [false, nil]
  end


  it 'can pick and change title/description of one task' do
    task = Task.new(title: "shopping", description: "go shopping", done:false)
    task.save
    task2 = Task.new(title: "laundry", description: "go shopping")
    task2.save
    Task.where(id=1)
    task.title = "bathroom"
    task.description = "clean"
    task.save
    expect(Task.all.pluck(:title)).to eq ["laundry", "bathroom"]
  end


  it 'can destroy a task' do
    task = Task.new(title: "shopping", description: "go shopping")
    task.save
    task2 = Task.new(title: "laundry", description: "whites")
    task2.save
    Task.find_by_title("laundry").destroy
    expect(Task.all.pluck(:title)).to eq ["shopping"]
  end

  it 'can set a due date' do
    task = Task.new(title: "shopping", description: "go shopping", done:false, due_date: "2016-10-11")
    task.save
    task2 = Task.new(title: "laundry", description: "whites")
    task2.save
    expect(Task.all.pluck(:due_date)).to eq ["2016-10-11", nil]
  end

  it 'can list all the records with a due date' do
    task = Task.new(title: "shopping", description: "go shopping", done:false, due_date: "2016-10-11")
    task.save
    task2 = Task.new(title: "laundry", description: "whites")
    task2.save
    expect(Task.where.not(due_date: nil).pluck(:title)).to include ["shopping"]
  end


end
