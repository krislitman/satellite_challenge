namespace :pull_data do

  task run: :envrionment do
    Satellite.destroy_all
    while True do
      SatelliteService.run
      sleep 10.seconds
    end
  end
end