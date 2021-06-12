class SatelliteService
  def self.run
    response = conn.get('/api/satellite/data')
    satellite = JSON.parse(response.body, symbolize_names: true)
    data = Satellite.create(
      last_updated: satellite[:last_updated],
      altitude: satellite[:altitude],
    )
    print(
      "Satellite #{data.id} created\nControl + C to exit\n\n"
    )
  end
  
  private 
  
  def self.conn
    Faraday.new(
      url: 'http://nestio.space',
      headers: { 'Content-Type' => 'application/json'}
    )
  end
end