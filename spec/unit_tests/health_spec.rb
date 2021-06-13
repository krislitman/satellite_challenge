require 'rails_helper'

RSpec.describe '/health', type: :request do
  describe "Request to api/v1/health" do 
    it 'Returns error with no data' do
    
      get '/api/v1/health'

      expect(response).not_to be_successful
      expect(response.status).to eq(500)
    end
  end
  
  
  describe 'If the average altitude is above 160km' do 
    it 'Returns a-ok message' do
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
  
  describe 'If the average altitude is below 160km for over a minute' do 
    it 'Returns danger message' do
      Satellite.destroy_all
      Altitude.destroy_all
      altitude = Altitude.create(status: "This should be a valid status")
      danger = Danger.new
      create(:satellite, altitude: 100)
      response1 = danger.current_check
      altitude.check_status(response1)
      create(:satellite, altitude: 100)
      response2 = danger.current_check
      altitude.check_status(response2)
      create(:satellite, altitude: 60)
      response3 = danger.current_check
      altitude.check_status(response3)
      create(:satellite, altitude: 60)
      response4 = danger.current_check
      altitude.check_status(response4)
      create(:satellite, altitude: 100)
      response5 = danger.current_check
      altitude.check_status(response5)
      create(:satellite, altitude: 100)
      response6 = danger.current_check
      altitude.check_status(response6)
      create(:satellite, altitude: 90)
      response7 = danger.current_check
      altitude.check_status(response7)

      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(expected[:data][:attributes][:message]).to eq("WARNING: RAPID ORBITAL DECAY IMMINENT")
      
      sleep 1.seconds
    end
  end
  
  describe 'Altitude can start off good' do 
    it 'And return danger message if it is below altitude for over a minute' do
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
      
      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(expected[:data][:attributes][:message]).to eq("Altitude is A-OK")
      
      create(:satellite, altitude: 100)
      response4 = danger.current_check
      altitude.check_status(response4)
      create(:satellite, altitude: 90)
      response5 = danger.current_check
      altitude.check_status(response5)
      create(:satellite, altitude: 75)
      response6 = danger.current_check
      altitude.check_status(response6)
      create(:satellite, altitude: 40)
      response7 = danger.current_check
      altitude.check_status(response7)
      altitude.check_status(response5)
      create(:satellite, altitude: 0)
      response8 = danger.current_check
      altitude.check_status(response8)
      create(:satellite, altitude: 0)
      response9 = danger.current_check
      altitude.check_status(response9)
      create(:satellite, altitude: 0)
      response10 = danger.current_check
      altitude.check_status(response10)
      
      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(expected[:data][:attributes][:message]).to eq("WARNING: RAPID ORBITAL DECAY IMMINENT")
      
      sleep 1.seconds
    end
  end
  
  describe 'If the satellite is no longer in danger' do 
    it 'Sustained message shows for one minute, and then back to normal' do
      Satellite.destroy_all
      Altitude.destroy_all
      altitude = Altitude.create(status: "This should be a valid status")
      danger = Danger.new
      create(:satellite, altitude: 100)
      response1 = danger.current_check
      altitude.check_status(response1)
      create(:satellite, altitude: 100)
      response2 = danger.current_check
      altitude.check_status(response2)
      create(:satellite, altitude: 60)
      response3 = danger.current_check
      altitude.check_status(response3)
      create(:satellite, altitude: 60)
      response4 = danger.current_check
      altitude.check_status(response4)
      create(:satellite, altitude: 100)
      response5 = danger.current_check
      altitude.check_status(response5)
      create(:satellite, altitude: 100)
      response6 = danger.current_check
      altitude.check_status(response6)
      create(:satellite, altitude: 90)
      response7 = danger.current_check
      altitude.check_status(response7)
      
      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(expected[:data][:attributes][:message]).to eq("WARNING: RAPID ORBITAL DECAY IMMINENT")
      
      create(:satellite, altitude: 1000)
      response8 = danger.current_check
      altitude.check_status(response8)
      
      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data][:attributes][:message]).to eq("Sustained Low Earth Orbit Resumed")
      
      create(:satellite, altitude: 170)
      response9 = danger.current_check
      altitude.check_status(response9)
      create(:satellite, altitude: 170)
      response10 = danger.current_check
      altitude.check_status(response10)
      create(:satellite, altitude: 170)
      response11 = danger.current_check
      altitude.check_status(response11)
      create(:satellite, altitude: 170)
      response12 = danger.current_check
      altitude.check_status(response12)
      create(:satellite, altitude: 170)
      response13 = danger.current_check
      altitude.check_status(response13)
      create(:satellite, altitude: 170)
      response14 = danger.current_check
      altitude.check_status(response14)
      create(:satellite, altitude: 170)
      response15 = danger.current_check
      altitude.check_status(response15)
      
      get '/api/v1/health'
      
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data][:attributes][:message]).to eq("Altitude is A-OK")
      
      sleep 1.seconds
    end
  end
end