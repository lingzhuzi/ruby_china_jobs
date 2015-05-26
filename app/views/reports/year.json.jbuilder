json.array!(@reports) do |report|
  json.extract! report, :name, :job_num, :type_id
  json.city    report.city.name
end
