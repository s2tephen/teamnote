json.array!(@notes) do |note|
  json.extract! note, :title, :content
  json.url note_url(note, format: :json)
end
