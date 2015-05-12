json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :url, :content, :published_at
  json.url job_url(job, format: :json)
end
