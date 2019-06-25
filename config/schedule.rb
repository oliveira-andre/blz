every 1.day, at: '00:01 am' do
  runner 'RebuildAllSchedulesService.execute'
end

every 1.hour do
  command 'backup perform -c /var/www/blz/backup/config.rb --trigger blzbackup'
end
