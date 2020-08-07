module FitbitAPI
  class Client
    API_VERSION = '1.2'

    # GET user/[user-id]/sleep/date/[date].json
    def sleep_logs(date = Date.today, opts = {})
      opts[:api_version] = API_VERSION
      get("user/#{user_id}/sleep/date/#{format_date(date)}.json", opts)
    end

    # GET user/[user-id]/sleep/date/[startDate]/[endDate].json
    def sleep_time_series(opts = {})
      opts[:api_version] = API_VERSION
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today

      if [start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      result = get("user/#{user_id}/sleep/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)

      result.values[0]
    end

    # POST https://api.fitbit.com/1.2/user/[user-id]/sleep.json
    # Log Sleep Record
    #
    # ==== POST Parameters
    # * +:startTime+ - activity start time; formatted in HH:mm:ss
    # * +:duration+ - duration in milliseconds
    # * +:date+ - log entry date; formatted in yyyy-MM-dd
    #
    def log_sleep(opts = {})
      opts[:api_version] = API_VERSION

      result = post("user/#{user_id}/sleep.json", opts)

      result.values[0]
    end
  end
end
