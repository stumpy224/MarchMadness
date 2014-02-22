json.array!(@results) do |result|
  json.extract! result, :id, :participant_id, :round, :year
  json.url result_url(result, format: :json)
end
