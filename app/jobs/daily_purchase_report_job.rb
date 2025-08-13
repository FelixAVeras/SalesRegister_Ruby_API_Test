class DailyPurchaseReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
