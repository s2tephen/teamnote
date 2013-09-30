class Note < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Bulk-generates notes with lorem ipsum.
  # Assumes that n is an integer.
  # n: number of notes to generate
  def self.generate(n)
    require 'lorem-ipsum'
    n.times do
      body = LoremIpsum.generate
      head = body.split(/\.|,/).last.truncate(40, :separator => ' ', :omission => '')[1..-1].capitalize
      note = Note.new(:title => head, :content => body)
      note.save
    end
  end
end
