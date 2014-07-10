class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


def make_histogram

    @stories = Story.all
    @stories.each {|story| story.title = story.title.chomp!}
    @source_keys = []

    @stories.latest_order.each do |story|
      @source_keys << story.area unless @source_keys.include?(story.area)
    end

    @recent_musically = @stories.musically.latest_order
    @recent_cmu = @stories.cmu.latest_order
    @recent_techcrunch_edu = @stories.techcrunch.is_education.latest_order
    @recent_techcrunch_music = @stories.techcrunch.is_music.latest_order
    @recent_venturebeat_edu = @stories.venturebeat.is_education.latest_order
    @recent_venturebeat_music = @stories.venturebeat.is_music.latest_order
    @recent_thenextweb_edu = @stories.thenextweb.is_education.latest_order
    @recent_learnegg = @stories.learnegg.is_education.latest_order

    @music_sources = @stories.is_music.latest_order
    @education_sources = @stories.is_education.latest_order

    @all_by_date = @stories.last_month.latest_order_18
    @all_by_a_to_z = @all_by_date.a_to_z

    @sources = [ @recent_musically, 
                 @recent_cmu,     
                 @recent_techcrunch_music,
                 @recent_venturebeat_music,
                 # @recent_learnegg,
                 @recent_techcrunch_edu,
                 # @recent_thenextweb_edu,
                 @recent_venturebeat_edu,
              ]

    @words = Array.new

    @stories.is_music.last_week.each do |story|

    	id = story.id
        all_words = story.title.gsub(/[[:space:]]/, ' ').split(" ") # rescue story = story.title.split(" ")
  
        	
        all_words.each do |word|

        	if word[-2..-1] == "'s" && word[0...-2] == word[0...-2].gsub(/\W+/, '')
        		@words.push([word[0...-2], id]) 

        	elsif word == word.gsub(/\W+/, '') && word[0] == word[0].upcase && (word.length > 2) && !(word == "The" ||
																				        			word == "And" ||
																				        			word == "Music" ||
																				        			word == "Education"||
																				        			word == "New" ||
																				        			word == "Why" ||
																				        			word == "With" ||
																				        			word == "How" ||
																				        			word == "Who" ||
																				        			word == "Where" ||
																				        			word == "After" ||
																				        			word == "Then" ||
																				        			word == "That" ||
																				        			word == "Language" ||
																				        			word == "Its")

	        		
					word = word.gsub(/\W+/, '')
					@words.push([word, id]) 
					p word[0]
			else
				# p word + ": rejected"
			end
		end

		# p @words
        	 
       end

    
 
  @wf = Hash.new(0)

  # @histogram = Hash.new(0)

  @words.each do |word| 
  	@wf[word[0]] += 1 
  end

  @wf = @wf.sort_by{|k, v| v}.reverse

  @freqs = @wf.map

  

@freqs.each do |item| 
	keyword = item[0] 
	frequency = item[1]

	@ids = Array.new

	@words.each do |word,id|

		if word == keyword
			@ids << id
		end
	end

	item[2] = @ids if @ids

end

# p @freqs
  
  
  # p @wf

  # @wf.each do |item|
  #   word = item[0].gsub(/\W+/, '')
  #   @histogram[word]=item[1] #unless word.downcase.not_valid_for_cloud? or word.not_proper?
  # end

  #   @histogram.each do |word,freq|
  #     if @histogram.include?(word) && @histogram.include?(word + 's')
  #       @histogram[word] = freq + @histogram[word + 's'].to_i
  #       @histogram.delete(word+'s')
  #     end
  #   end
  end

end
