class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string 'task_name', limit: 50, null: false
      t.string 'description', null: false
      t.boolean 'status', null: false, default: false
      t.timestamps null: false
    end
  end
end
