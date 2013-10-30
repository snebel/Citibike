class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :origin
      t.string :destination
      t.float :origin_lat
      t.float :origin_long
      t.float :destination_lat
      t.float :destination_long
      t.float :origin_closest_station_lat
      t.float :origin_closest_station_long
      t.float :dest_closest_station_lat
      t.float :dest_closest_station_long

      t.timestamps
    end
  end
end
