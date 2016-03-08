class TodocontrollerController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  def index
  end

  def new
    @task = Task.find_or_create_by(task_name: params[:name], description: params[:desc], status: 0)
    @task.save!
    params[:tags].each do |t|
      @task.tags.find_or_create_by(tag: t['text'])
    end
    @tasks = Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def search
    puts params
    @tag = Tag.find_by(tag: params[:tag])
    puts @tag

    @tasks = @tag.tasks

    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def toggle_status
    @task = Task.find_by(id: params[:id])
    if @task.status === false
      @task.update(status: true)
    else
      @task.update(status: false)
                    end
    @task.save
    @tasks = Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def show_completed
    @tasks_completed = Task.where(status: true)
    respond_to do |format|
      format.html { render json: @tasks_completed.to_json(include: [:tags]) }
      format.json { render json: @tasks_completed.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def show_incomplete
    @tasks_incomplete = Task.where(status: false)
    respond_to do |format|
      format.html { render json: @tasks_incomplete.to_json(include: [:tags]) }
      format.json { render json: @tasks_incomplete.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def show_all
    @tasks = Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end

  def delete
    @task = Task.find_by(id: params[:id])
    @task.destroy
    @tasks = Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }

    end
  end

  def delete_completed
    puts 'testing line'
    puts params
    @tasks = Task.where(status: true)
    @tasks.destroy_all
    @tasks=Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end

  end

  def update_task
    data = JSON.parse(params[:data])
    puts "sdfsdfsdfsdf"
    puts "sdfsdfsdfsdf"
    puts data["id"]
    puts "sdfsdfsdfsdf"
    puts "sdfsdfsdfsdf"
    @task = Task.find(data["id"])
    @task.task_name = data["name"]
    @task.description = data["desc"]
    @task.save!
    @idList = []
    data["tags"].each do |t|
      @exist_tag = Tag.find_by(tag: t["text"])
      if @exist_tag.nil?
        @tag = Tag.create(tag: t["text"])
        @idList.push(@tag.id)
      else
        @idList.push (@exist_tag.id)
    end
    end
    @task.tag_ids = @idList
    @tasks = Task.all
    respond_to do |format|
      format.html { render json: @tasks.to_json(include: [:tags]) }
      #format.json { render json: @tasks.to_json(include: [:tags]) }
      #format.xml { render xml: @tasks }
    end
  end
end
