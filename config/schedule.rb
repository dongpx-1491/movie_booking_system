# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# whenever --update-crontab

set :environment, "development"
set :output, "log/cron_log.log"
env :PATH, ENV["PATH"]

#check_expiration of payments every 5 minutes
every 2.minutes do
  rake "delete_namespace:delete_payments_expired", environment: "development"
end

every 1.minutes do
  rake "update_namespace:update_movie_revenue", environment: "development"
end
