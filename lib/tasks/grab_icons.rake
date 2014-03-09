namespace :grab_icons do
 task :grab_icons => :environment do

 		file = File.open('/Users/Lemez/Dropbox/T10 COSIMO JON/rebeats/app/assets/images/icons.txt', 'w')
		array = []
		response = HTTParty.get('http://www.officialcharts.com/music-charts/')
		doc = Nokogiri::HTML(response)
		doc.css('td img').each do |rip| 
			x = rip['src'] unless rip['src'].include?('affiliates') rescue x = nil
			x = nil unless rip['src'].include?('http')

			array << x unless array.include?(x)
			
		end
		file.write(array)
		file.close
		# puts f.title, f.url, rip

		#raw_parameters = { :source => "officialcharts", :title => f.title, :url => f.url, :modified => f.last_modified, :pic_url => rip}
		
		#puts raw_parameters

		# puts "a"
		# parameters = ActionController::Parameters.new(raw_parameters)
		# puts "b"
		# @story = Story.new(parameters.require(:title, :url, :source).permit(:pic, :modified))
		# puts "c"
		# if @story.save
		# 	puts "d"
		# else
		# 	puts "no"
		# end


		# @story = Story.new
		# @story.source = raw_parameters[:source]
		# @story.title = raw_parameters[:title]
		# @story.url = raw_parameters[:url]
		# @story.modified = raw_parameters[:modified]
		# @story.pic_url = raw_parameters[:pic_url]
		# @story.save
				
end
end