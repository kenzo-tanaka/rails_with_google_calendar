class SchedulesController < ApplicationController
  before_action :authenticate_user!

  # @see https://developers.google.com/calendar/quickstart/ruby
  def daily
    events = Schedule.get_today_events(current_user)

    respond_to do |format|
      format.json { render json: { events: events } }
    end
  end
end
