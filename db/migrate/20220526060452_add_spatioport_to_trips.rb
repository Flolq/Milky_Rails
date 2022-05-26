class AddSpatioportToTrips < ActiveRecord::Migration[6.1]
  def change
    add_reference :trips, :spatioport
  end
end
