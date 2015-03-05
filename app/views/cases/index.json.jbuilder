json.array!(@cases) do |case|
  json.extract! case, :id, :title, :sponsor, :description
  json.url case_url(case, format: :json)
end
