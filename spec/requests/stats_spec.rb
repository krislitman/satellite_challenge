require 'rails_helper'

RSpec.describe '/stats', type: :request do
  scenario 'Returns success code' do
  
  get '/api/v1/stats'
  
  expect(response).to be_successful
  expect(response.status).to eq(200)
  end
  
  scenario '/stats can return minimum altitude for past 5 minutes' do 
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
  end
end