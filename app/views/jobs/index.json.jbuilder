json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :url, :content
  json.url job_url(job, format: :json)
end
