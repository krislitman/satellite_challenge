namespace :pull_data do

  task run: :environment do
    Satellite.destroy_all
    while true do
      SatelliteService.run
      sleep 10.seconds
    end
  end
end