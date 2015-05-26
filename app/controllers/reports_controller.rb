class ReportsController < ApplicationController
  def total
    @reports = Report.where(type_id: Report::TOTAL).includes(:city).order('job_num desc')
  end

  def year
    @reports = search(Report::YEAR)
  end

  def month
    @reports = search(Report::MONTH)
  end

  private
  def search(type_id)
    cities = (params[:cities] || '').split(',')
    from   = parse_date(params[:from], type_id)
    to     = parse_date(params[:to],   type_id)

    reports = Report.includes(:city).where(type_id: type_id).order('name, job_num desc')
    reports = reports.where('name >= ? and name <= ?', from, to)
    reports = reports.where(city_id: cities) if cities.size > 0

    reports
  end

  def parse_date(date_str, type_id)
    year, month = (date_str || '').split('-')
    today = Date.today
    year  = today.year.to_s  unless year
    month = today.month.to_s unless month
    month = month.rjust(2, '0')

    result = ''
    result << "#{year}年"
    result << "#{month}月" if type_id == Report::MONTH

    result
  end
end
