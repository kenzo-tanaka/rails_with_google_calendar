class Schedule < ApplicationRecord
  CALENDAR_ID = 'primary'
  MAX_RESULTS = 100

  # 今日のイベントを取得
  def self.get_today_events(user)
    time_min = Date.today.in_time_zone('Asia/Tokyo').to_datetime
    time_max = Date.tomorrow.in_time_zone('Asia/Tokyo').to_datetime
    response = Schedule.fetch_google_calendar(user, time_min, time_max)

    events = format_response(response)
  end

  # 今週のイベントを取得
  def self.get_this_week_events(user)
    time_min = Date.today.beginning_of_week.in_time_zone('Asia/Tokyo').to_datetime
    time_max = Date.today.end_of_week.in_time_zone('Asia/Tokyo').to_datetime
    response = Schedule.fetch_google_calendar(user, time_min, time_max)

    events = format_response(response)
  end

  private
    # リクエストを送信
    def self.fetch_google_calendar(user, time_min, time_max)
      client = user.get_google_calendar_client
      response = client.list_events(
        CALENDAR_ID,
        max_results: MAX_RESULTS,
        single_events: true,
        order_by: 'startTime',
        time_min: time_min,
        time_max: time_max
      )
    end

    # レスポンスを整形
    def self.format_response(res)

      # TODO: 修正
      events = ''
      events << "#{I18n.l Time.zone.now, format: :date}\n"

      res.items.each do |e|
        start_time = e.start.date || e.start.date_time
        end_time = e.end.date || e.end.date_time
        events << "#{I18n.l start_time, format: :time} 〜 #{I18n.l end_time, format: :time}： #{e.summary}\n"
      end
      events
    end
end
