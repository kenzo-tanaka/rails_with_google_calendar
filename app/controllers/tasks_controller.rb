class TasksController < ApplicationController
  CALENDAR_ID = 'primary'

  def index; end

  # リソースを作成するわけではないので命名変更
  def create
    client = current_user.get_google_calendar_client
    response = client.list_events(
      CALENDAR_ID,
      max_results: 50,
      single_events: true,
      order_by: 'startTime',
      time_min: Time.zone.now)

    response.items.each do |e|
      start = e.start.date || e.start.date_time
      puts "#{e.summary}: #{start}"
    end
  end

end
