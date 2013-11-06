class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :address
      t.float :lat
      t.float :lng
      t.integer :station_id
      t.float :station_lat
      t.float :station_lng

      t.timestamps
    end
  end
end
