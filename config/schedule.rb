every 1.day, at: '00:01 am' do
  runner 'RebuildAllSchedulesJob.perform_later'
end

every 59.minutes do
  command 'backup perform -c /var/www/blz/backup/config.rb --trigger blzbackup'
end

every 1.hour do
  runner 'CancelSchedulingTimedOutJob.perform_later'
end

every 1.minute do
  runner 'SchedulingReminderJob.perform_later'
end
