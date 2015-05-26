json.array!(@reports) do |report|
  json.job_num report.job_num
  json.city    report.city.name
end
