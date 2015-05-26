class Report < ActiveRecord::Base
  belongs_to :city

  TOTAL = 1
  YEAR = 2
  MONTH = 3

  def self.generate_total_report
    generate(TOTAL)
  end

  def self.generate_year_report(year)
    date = Date.new(year)
    range = date...(date + 1.year)
    generate(YEAR, range)
  end

  def self.generate_month_report(year, month)
    date = Date.new(year, month)
    range = date...(date + 1.month)
    generate(MONTH, range)
  end

  private
  def self.generate(type_id, date_range=nil)
    City.all.each do |city|
      jobs  = Job.where('title like ?', "%#{city.name}%")
      jobs  = jobs.where(published_at: date_range) if date_range
      count = jobs.count

      name = generate_name(type_id, date_range)
      options = {name: name, type_id: type_id, city_id: city.id}
      report = self.find_by(options)
      options.merge!({job_num: count})
      if report
        report.update_attributes!(options)
      else
        self.create!(options)
      end
    end
  end

  def self.generate_name(type_id, date_range=nil)
    if type_id == TOTAL
      'Ruby'
    elsif type_id == YEAR
      date_range.first.strftime("%Y年")
    else
      date_range.first.strftime("%Y年%m月")
    end
  end
end
