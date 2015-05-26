namespace :job do
  desc "download job data from RubyChina"
  task :sync => :environment do
    puts "数据同步开始，请稍候..."
    JobSyncTask.new.sync
    puts "数据同步完成"
  end

  desc "生成总量报表"
  task :total_report => :environment do
    Report.generate_total_report
  end

  desc "生成年度报表"
  task :year_report => :environment do
    year = Date.today.year
    Report.generate_year_report(year)
  end

  desc "生成月度报表"
  task :month_report => :environment do
    today = Date.today
    year  = today.year
    month = today.month
    Report.generate_month_report(year, month - 1)
    Report.generate_month_report(year, month)
  end

end