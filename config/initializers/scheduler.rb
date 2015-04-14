require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.in '1d' do
  Job.download_data
end