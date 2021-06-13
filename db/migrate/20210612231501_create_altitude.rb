class CreateAltitude < ActiveRecord::Migration[5.2]
  def change
    create_table :altitudes do |t|
      t.string :status
      
      t.timestamps
    end
  end
end
