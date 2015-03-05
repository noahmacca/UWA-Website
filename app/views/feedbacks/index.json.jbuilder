json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :giver, :good_comments, :improvement_comments, :leadership, :creativity
  json.url feedback_url(feedback, format: :json)
end
