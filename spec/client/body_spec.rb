require "spec_helper"

describe FitbitAPI::Client do
  let(:client) do
    FitbitAPI::Client.new(
      client_id: "ABC123",
      client_secret: "xyz789",
    )
  end

  describe "#time_series_request" do
    it "makes a request for a period" do
      opts ={
        period: "1w",
      }
      test_templates = {
        period: "%{period}",
      }

      expect(client.time_series_request(test_templates, opts)).to eq(opts[:period])
    end

    it "makes a request for a range" do
      opts ={
        start_date: "2020-10-20",
        end_date: "2020-11-20",
      }
      test_templates = {
        range: "%{start_date}-%{end_date}",
      }
      expected = test_templates[:range] % opts

      expect(client.time_series_request(test_templates, opts)).to eq(expected)
    end
  end
end
