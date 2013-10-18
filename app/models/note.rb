class Note < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Do not allow empty fields.
  validates :title, :content, :presence => { :message => "* required" }

  has_many :permissions
  has_many :users, through: :permissions
end
