class RemoveDefault < ActiveRecord::Migration
  def change
    change_column :tasks,:status,:boolean,:default=>nil
  end
end
