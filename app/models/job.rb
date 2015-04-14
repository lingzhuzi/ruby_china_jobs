require 'open-uri'

class Job < ActiveRecord::Base

  SITE_URL = 'https://ruby-china.org'
  INDEX_URL = "#{SITE_URL}/jobs"

  def self.download_data(url=INDEX_URL)
    Rails.logger.debug "download from : #{url}"
    doc = Nokogiri::HTML(open(url))
    doc.css('.topic .infos .title a').each do |topic|
      title = topic.content
      url = "#{SITE_URL}#{topic.attr('href')}"

      Rails.logger.debug "job: #{title}"

      job = self.find_or_create_by(url: url)
      job.title = title
      job.save
    end

    next_page_link = doc.css('.pagination .next_page a').first
    if next_page_link
      url = next_page_link.attr('href')
      if url == '#'
        Rails.logger.info "all jobs data downloaded"
      else
        download_data("#{SITE_URL}#{url}")
      end
    end
  end
end
