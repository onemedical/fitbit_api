require 'spec_helper'

describe FitbitAPI::Client do
  let(:client) do
    FitbitAPI::Client.new(
      client_id: 'ABC123',
      client_secret: 'xyz789',
      user_id:'bob',
      access_token: 'test',
      refresh_token: 'test'
    )
  end

  describe '#time_series' do
    it 'makes a request for a period' do
      allow(client).to receive(:set_client) do
        true
      end

      opts ={
        period: "1w",
        refresh_token: "refresh"
      }
      test_templates = {
        period: "%{period}",
      }

      expect(client.time_series(test_templates, opts)).to eq(opts.period)
    end
  end
end
