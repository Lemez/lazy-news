class AddAttachmentPicToStories < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :stories, :pic
  end
end
