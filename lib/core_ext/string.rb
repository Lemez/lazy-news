class String

	def fix_asset_path
		self.split("/").reject{|c| c=='assets'}.join("/")
	end

	def is_common
		self == "The" ||
		self == "Company" ||
		self == "And" ||
		self == "Music" ||
		self == "Education"||
		self == "New" ||
		self == "Why" ||
		self == "With" ||
		self == "How" ||
		self == "Who" ||
		self == "Where" ||
		self == "After" ||
		self == "Then" ||
		self == "That" ||
		self == "Language" ||
		self == "Its"
	end

	def is_music_source(sources)

		sources.each {|source| return true if self.upcase == source.upcase}
			
		false
	end

	def is_acceptable?(sources)
		self == self.gsub(/\W+/, '') && 
		self[0] == self[0].upcase && 
		(self.length > 2) && 
		!self.is_common &&
		!self.is_music_source(sources)
	end
end