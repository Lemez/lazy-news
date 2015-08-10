class Startup < ActiveRecord::Base

validates :area, presence: true
validates :name, presence: true, uniqueness: true
validates :strapline, presence: true
validates :pic_url, presence: true

attr_accessible :area, :name, :strapline, :pic_url, :twitter, :source, :modified 

end
