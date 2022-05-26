class CreateSpatioports < ActiveRecord::Migration[6.1]
  def change
    create_table :spatioports do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
