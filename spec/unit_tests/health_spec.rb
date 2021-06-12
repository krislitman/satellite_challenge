require 'rails_helper'

RSpec.describe '/health', type: :request do
  describe "Request to api/v1/health" do 
    it 'Returns error with no data' do
    
      get '/api/v1/health'

      expect(response).not_to be_successful
      expect(response.status).to eq(500)
    end
  end
  
  
  describe '/stats can return minimum altitude for past 5 minutes' do 
    xit 'returns the expected data' do
      Satellite.destroy_all
      satellites = create_list(:satellite, 10)
      least = satellites.first
      bad = create(
        :satellite, last_updated: 10.minutes.ago, altitude: 100
      )

      get '/api/v1/stats'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data]).to be_a(Hash)
      expect(expected[:data][:attributes].keys).to include(:minimum)
      expect(expected[:data][:attributes][:minimum][0]).not_to eq(bad.altitude)
      expect(expected[:data][:attributes][:minimum][0]).to eq(least.altitude)

      sleep 1.seconds
    end
  end
end