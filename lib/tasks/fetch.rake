namespace :job do
  desc "download job data from RubyChina"
  task :download => :environment do
    puts "数据同步开始，请稍后..."
    Job.download_data
    puts "数据同步完成"
  end
end