class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :story_id
      t.integer :clicks

      t.timestamps
    end
  end
end
