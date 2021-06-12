namespace :pull_data do

  task run: :environment do
    Satellite.destroy_all
    danger = Danger.new
    while true do
      SatelliteService.run
      response = danger.current_check
      Satellite.status(response)
      sleep 10.seconds
    end
  end
end