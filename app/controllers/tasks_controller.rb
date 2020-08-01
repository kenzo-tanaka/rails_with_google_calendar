class TasksController < ApplicationController
  before_action :authenticate_user!

  CALENDAR_ID = 'primary'
  MAX_RESULTS = 50

  def index; end

  # @see https://developers.google.com/calendar/quickstart/ruby
  def fetch_today_events
    client = current_user.get_google_calendar_client
    response = client.list_events(
      CALENDAR_ID,
      max_results: MAX_RESULTS,
      single_events: true,
      order_by: 'startTime',
      time_min: Time.zone.today.to_datetime,
      time_max: Time.zone.tomorrow.to_datetime)

    events = ""
    response.items.each do |e|
      start = e.start.date || e.start.date_time
      events << "#{e.summary}: #{start}"
    end

    respond_to do |format|
      format.json { render json: { events: events } }
    end
  end
end
