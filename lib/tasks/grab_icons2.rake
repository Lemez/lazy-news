 task grab_icons2: :environment do

		response = HTTParty.get('http://www.officialcharts.com/music-charts/')
		doc = Nokogiri::HTML(response)
		doc.css('div.infoHolder img').each do |link|
			image = link['src'][-25..-1]
			location = ("/Users/JW/rebeats/images")
			File.open(location, 'wb').write(image)
		end

end