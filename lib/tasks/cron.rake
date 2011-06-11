desc "Cron runs once a day"

task :cron => :environment do
  Task.reset_old_deferred_tasks
end