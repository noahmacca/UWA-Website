json.array!(@execs) do |exec|
  json.extract! exec, :id, :exec_name, :team, :responsibilities, :program
  json.url exec_url(exec, format: :json)
end
