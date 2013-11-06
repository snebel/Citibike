class UserHasManyPlaces < ActiveRecord::Migration
  def change
  	add_reference :places, :user_id
  end
end
