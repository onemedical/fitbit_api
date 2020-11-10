module FitbitAPI
  class Client
    BODY_RESOURCES = %w(bmi fat weight)

    def weight_logs(opts={})
      period_template = "user/%{user_id}/body/log/weight/date/%{start_date}/%{period}.json"
      range_template = "user/%{user_id}/body/log/weight/date/%{start_date}/%{end_date}.json"

      time_series('weight', period_template, range_template, opts)
    end

    def body_fat_logs(date=Date.today, opts={})
      get("user/-/body/log/fat/date/#{format_date(date)}.json", opts)
    end

    def body_time_series(resource, opts={})
      unless BODY_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{BODY_RESOURCES}."
      end

      period = "user/%{user_id}/body/%{resource}/date/%{end_date}/%{period}.json"
      range = "user/%{user_id}/body/%{resource}/date/%{start_date}/%{end_date}.json"

      result = time_series(resource, period, range, opts)

      # remove root key from response
      result.values[0]
    end

    def log_weight(opts)
      post("user/#{user_id}/body/log/weight.json", opts)
    end

    def delete_weight_log(weight_log_id, opts={})
      delete("user/#{user_id}/body/log/weight/#{weight_log_id}.json", opts)
    end

    def log_body_fat(opts)
      post("user/#{user_id}/body/log/fat.json", opts)
    end

    def delete_body_fat_log(body_fat_log_id, opts={})
      delete("user/#{user_id}/body/log/fat/#{body_fat_log_id}.json", opts)
    end

    def time_series(resource, period_endpoint_template, range_endpoint_template, opts={})
      opts = {
        start_date: Date.today,
        end_date: Date.today,
      }.merge(opts)

      start_date = opts[:start_date]
      end_date   = opts[:end_date]
      period     = opts[:period]

      if period
        result = get(period_endpoint_template % { user_id: user_id, resource: resource, start_date: format_date(start_date), end_date: format_date(end_date), period: period }, opts)
      else
        result = get(range_endpoint_template % { user_id: user_id, resource: resource, start_date: format_date(start_date), end_date: format_date(end_date) }, opts)
      end

      if [period, start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      result
    end
  end
end
