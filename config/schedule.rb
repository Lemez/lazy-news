# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "#{path}/log/cron.log"
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

# Learn more: http://github.com/javan/whenever

set :output, {:error => "#{path}/log/cron_error_log.log", :standard => "#{path}/log/cron_log.log"}
set :environment, "development"

job_type :rake,  "cd :path && :environment_variable=:environment :bundle_command rake :task :output"

every 60.minutes do
	rake "grab_tasks:execute_all"
end

# update with `whenever -w`
