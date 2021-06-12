namespace :pull_data do

  task run: :environment do
    Satellite.destroy_all
    Altitude.destroy_all
    altitude = Altitude.create(status: " ")
    danger = Danger.new
    while true do
      SatelliteService.run
      response = danger.current_check
      altitude.check_status(response)
      sleep 10.seconds
    end
  end
end