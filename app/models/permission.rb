class Permission < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
end
