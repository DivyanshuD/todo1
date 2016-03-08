class Tag < ActiveRecord::Base
has_and_belongs_to_many :tasks
validates :tag, presence: true
end
