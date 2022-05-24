class CreateShuttles < ActiveRecord::Migration[6.1]
  def change
    create_table :shuttles do |t|
      t.string :model
      t.integer :max_capacity

      t.timestamps
    end
  end
end
