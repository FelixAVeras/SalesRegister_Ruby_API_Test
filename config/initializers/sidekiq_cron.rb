# require 'sidekiq/cron/job'

# Sidekiq::Cron::Job.create(
#   name: 'Daily Purchase Report - every day at 7am',
#   cron: '0 7 * * *', # cada día a las 7:00 AM
#   class: 'DailyPurchaseReportJob'
# )