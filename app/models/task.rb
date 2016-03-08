class Task < ActiveRecord::Base
has_and_belongs_to_many :tags
validates :task_name, presence: true
validates :description, presence: true
validates :status, presence: false
end
