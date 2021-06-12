class CreateSatellite < ActiveRecord::Migration[5.2]
  def change
    create_table :satellites do |t|
      t.datetime :last_updated
      t.float :altitude
      
      t.timestamps
    end
  end
end
