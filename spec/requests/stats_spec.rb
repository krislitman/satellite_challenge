require 'rails_helper'

RSpec.describe '/stats', type: :request do
  describe "Request to api/v1/stats" do 
    it 'Returns error with no data' do
    
      get '/api/v1/stats'

      expect(response).not_to be_successful
      expect(response.status).to eq(500)
    end
  end
  
  
  describe 'Stats can return minimum altitude for past 5 minutes' do 
    it 'Returns the expected data' do
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
      expect(expected[:data][:attributes][:minimum]).not_to eq(bad.altitude)
      expect(expected[:data][:attributes][:minimum]).to eq(least.altitude)

      sleep 1.seconds
    end
  end
  
  describe 'Can return maximum altitude for past 5 minutes' do 
    it 'Returns the expected data' do
      Satellite.destroy_all
      satellites = create_list(:satellite, 10)
      max = satellites.last
      bad = create(
        :satellite, last_updated: 10.minutes.ago, altitude: 500.55
      )

      get '/api/v1/stats'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data]).to be_a(Hash)
      expect(expected[:data][:attributes].keys).to include(:maximum)
      expect(expected[:data][:attributes][:maximum]).not_to eq(bad.altitude)
      expect(expected[:data][:attributes][:maximum]).to eq(max.altitude)

      sleep 1.seconds
    end
  end
  
  describe 'Can return average altitude for past 5 minutes' do 
    it 'Returns the expected data' do
      Satellite.destroy_all
      satellites = create_list(:satellite, 10)
      bad = create(
        :satellite, last_updated: 10.minutes.ago, altitude: 200
      )
      all_avgs = satellites.map(&:altitude)
      expected_avg = all_avgs.sum / all_avgs.count

      get '/api/v1/stats'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data]).to be_a(Hash)
      expect(expected[:data][:attributes].keys).to include(:average)
      expect(expected[:data][:attributes][:average]).to eq(expected_avg)

      sleep 1.seconds
    end
  end
end