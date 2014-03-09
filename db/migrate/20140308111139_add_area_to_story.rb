class AddAreaToStory < ActiveRecord::Migration
  def change
    add_column :stories, :area, :string
  end
end
