require 'open-uri'

class JobSyncTask

  SITE_URL = 'https://ruby-china.org'
  INDEX_URL = "#{SITE_URL}/jobs"

  def sync(url=INDEX_URL)
    parse_index_page(url)
  end

  private
  def document(url)
    doc = Nokogiri::HTML(open(url))
  rescue => e
    Rails.logger.error "error occurred when parse #{url}"
    Rails.logger.error e.backtrace.join("\n")
  ensure
    return doc
  end

  def parse_index_page(url)
    doc = document(url)
    return unless doc
    doc.css('.topic .infos .title a').each do |topic|
      title = topic.content
      url = "#{SITE_URL}#{topic.attr('href')}"

      Rails.logger.debug "job: #{title}"
      puts "job: #{title}"

      details = job_details(title, url)
      if details
        job = Job.find_or_create_by(url: url)
        job.update_attributes(details)
      end
    end

    next_page_url = next_page_url(doc)
    parse_index_page(next_page_url) if next_page_url
  end

  def next_page_url(document)
    link = document.css('.pagination .next_page a').first
    if link
      url = link.attr('href')
      return "#{SITE_URL}#{url}" if valid_url?(url)
    end
  end

  def valid_url?(url)
    url = url.strip.downcase
    return false if url.start_with?('#')
    return false if url.start_with?('javascript:')
    return true
  end

  def job_details(title, url)
    doc = document(url)
    return unless doc

    detail = {title: title, url: url}
    info   = doc.css('.topic-detail .info .timeago').first
    body   = doc.css('.topic-detail').first

    if body
      body.css('.info').remove()
      body.css('.panel-footer').remove()
      body.css('.social-share-button').remove()
      detail[:content] = body.text.strip
    end
    detail[:published_at] = info.attr('title') if info

    detail
  end

end