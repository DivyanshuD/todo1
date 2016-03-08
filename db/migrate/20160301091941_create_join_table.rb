class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tasks, :tags do |t|
      t.index [:task_id, :tag_id], unique: true
      t.index [:tag_id, :task_id], unique: true
    end
  end
end
