class AddModifiedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :modified, :datetime
  end
end
