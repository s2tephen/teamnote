class Note < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Do not allow empty fields.
  validates :title, :content, :presence => { :message => "* required" }

  has_many :permissions
  has_many :users, through: :permissions

  # Bulk-generates notes with lorem ipsum.
  # Assumes that n is an integer.
  # Assigns ownership to first user (i.e. admin).
  # n: number of notes to generate
  def self.generate(n)
    require 'lorem-ipsum'
    n.times do
      body = LoremIpsum.generate
      head = body.split(/\.|,/).last.truncate(40, :separator => ' ', :omission => '')[1..-1].capitalize
      note = Note.new(:title => head, :content => body)
      note.save
      permission = Permission.new(:user_id => 1, :note_id => note.id)
      permission.save
    end
  end
end
