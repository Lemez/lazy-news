class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :source
      t.string :area
      t.string :name
      t.string :strapline
      t.string :twitter
      t.datetime :modified
      t.string :pic_url

      t.timestamps
    end
  end
end
