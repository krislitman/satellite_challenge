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
      create(:satellite, altitude: 150)
      create_list(:satellite, 10, altitude: 170)

      get '/api/v1/health'

      expected = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      expect(expected[:data]).to be_a(Hash)
      # expect(expected[:data][:attributes].keys).to include(:message)

      sleep 1.seconds
    end
  end
end