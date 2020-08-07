module FitbitAPI
  class Client
    # GET user/[user-id]/sleep/date/[date].json
    def sleep_logs(date = Date.today, opts = {})
      get("user/#{user_id}/sleep/date/#{format_date(date)}.json", opts)
    end

    # GET user/[user-id]/sleep/date/[startDate]/[endDate].json
    def sleep_time_series(opts = {})
      opts[:api_version] = "1.2"
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today

      if [start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      result = get("user/#{user_id}/sleep/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)

      result.values[0]
    end
  end
end
