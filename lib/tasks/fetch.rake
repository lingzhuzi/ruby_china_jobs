namespace :job do
  desc "download job data from RubyChina"
  task :sync => :environment do
    puts "数据同步开始，请稍后..."
    JobSyncTask.new.sync
    puts "数据同步完成"
  end
end