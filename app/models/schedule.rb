class Schedule < ApplicationRecord
  CALENDAR_ID = 'primary'
  MAX_RESULTS = 50

  # 今日のタスクを取得
  def self.get_today_events(user)
    client = user.get_google_calendar_client
    response = client.list_events(
      CALENDAR_ID,
      max_results: MAX_RESULTS,
      single_events: true,
      order_by: 'startTime',
      time_min: Time.zone.today.to_datetime,
      time_max: Time.zone.tomorrow.to_datetime)

    events = ""
    events << "#{I18n.l Time.zone.now, format: :date}<br>"

    response.items.each do |e|
      start_time = e.start.date || e.start.date_time
      end_time = e.end.date || e.end.date_time

      # AjaxでHTML置換するので<br>を入れている
      events << "#{I18n.l start_time, format: :time} 〜 #{I18n.l end_time, format: :time}： #{e.summary}<br>"
    end

    events
  end
end
