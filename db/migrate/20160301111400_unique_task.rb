class UniqueTask < ActiveRecord::Migration
  def change
    add_index :tasks,:task_name,:unique=>true
  end
end
