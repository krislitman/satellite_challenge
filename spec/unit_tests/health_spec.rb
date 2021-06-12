require 'rails_helper'

RSpec.describe '/health', type: :request do
  describe "Request to api/v1/health" do 
    it 'Returns error with no data' do
    
      get '/api/v1/health'

      expect(response).not_to be_successful
      expect(response.status).to eq(500)
    end
  end
  
  
  describe '/health if the average altitude goes below 160km for more than 1 min' do 
    it 'returns a warning message' do
      Satellite.destroy_all
      Altitude.destroy_all
      altitude = Altitude.create(status: "This should be a valid status")
      danger = Danger.new
      create(:satellite, altitude: 170)
      response1 = danger.current_check
      altitude.check_status(response1)
      create(:satellite, altitude: 170)
      response2 = danger.current_check
      altitude.check_status(response2)
      create(:satellite, altitude: 170)
      response3 = danger.current_check
      altitude.check_status(response3)
      create(:satellite, altitude: 170)
      response4 = danger.current_check
      altitude.check_status(response4)
      create(:satellite, altitude: 170)
      response5 = danger.current_check
      altitude.check_status(response5)
      create(:satellite, altitude: 170)
      response6 = danger.current_check
      altitude.check_status(response6)

      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(expected[:data]).to be_a(Hash)
      expect(expected[:data].keys).to include(:id)
      expect(expected[:data].keys).to include(:type)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('satellite_health')
      expect(expected[:data][:attributes].keys).to include(:message)
      expect(expected[:data][:attributes][:message]).to eq("Altitude is A-OK")

      sleep 1.seconds
    end
  end
end