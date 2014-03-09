class AddPicUrlToStories < ActiveRecord::Migration
  def change
    add_column :stories, :pic_url, :string
  end
end
