class Story < ActiveRecord::Base

# include ActiveModel::ForbiddenAttributesProtection

# attr_reader :modified

validates :title, presence: true
validates :url, presence: true, uniqueness: true

# has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
# , :default_url => "/images/womex.jpg"

def self.is_valid?
	# self.modified < Date.today
end

def self.ordered
	self.order(modified: :desc) #.is_valid?
end

def self.a_to_z
	self.order(title: :asc) #.is_valid?
end

def self.latest_order
	self.ordered.limit(8)
end

def self.latest_order_hundred
	self.ordered.limit(100)
end

# def self.to_icon
# return "assets/icon_3688" if self == "education"
# return "assets/icon_1231" if self == "music"
# end




scope :venturebeat, -> { where(source:"venturebeat") }
scope :techcrunch, -> { where(source:"techcrunch") } 
scope :musically, -> { where(source:"musically") }
scope :thenextweb, -> { where(source:"thenextweb") }
scope :learnegg, -> { where(source:"learnegg") }

scope :is_music, -> {where(area:"music")}
scope :is_education, -> {where(area:"education")}

# scope :this_week, -> {where()}


# scope :is_valid_date, -> { where(modified: <Date.today)}



end
