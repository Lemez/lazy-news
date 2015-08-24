require 'secure_headers'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # ensure_security_headers

  before_action do |controller|
    controller.session['flash'].try(:stringify_keys!)
  end



def get_top_stories

    @stories = Story.all.uniq(&:url)

    @words = Array.new

    @relevant_stories = @stories.last_month

    @current_sources = []
    @relevant_stories.each {|story| @current_sources << story.source unless @current_sources.include?(story.source)}
    
    @relevant_stories.each do |story|

    	id = story.id
        all_words = story.title.gsub(/[[:space:]]/, ' ').split(" ") # rescue story = story.title.split(" ")
  
        	
        all_words.each do |word|

        	if word[-2..-1] == "'s" && word[0...-2] == word[0...-2].gsub(/\W+/, '')
        		@words.push([word[0...-2], id]) 

        	elsif word.is_acceptable?(@current_sources)

				word = word.gsub(/\W+/, '')
				@words.push([word, id]) 

			else
				# p word + ": rejected"
			end

		end
        	 
    end

    
 
	@wf = Hash.new(0)

	  # @histogram = Hash.new(0)

  	@words.each { |word| @wf[word[0]] += 1 }
	@wf = @wf.sort_by{|k, v| v}.reverse

	@freqs = @wf.map # turn Hash to array
	@freqs.each do |item| 

		@ids = Array.new
		keyword = item[0] 
		frequency = item[1]

		@words.each { |word,id| @ids << id if word == keyword }
		item[2] = @ids if @ids

	end

	@stories_of_the_week = []

	minimum_frequency = 1

	@freqs.each {|item| @stories_of_the_week << item if item[1] >= minimum_frequency}

	return @stories_of_the_week

	
# check tags and stories are not overlapping - ie Amazon and Prime
	# @stories_of_the_week.each do |story|
	# 	@stories_of_the_week.each do |otherstory|

	# 		index = @stories_of_the_week.index(otherstory)
	# 		@stories_of_the_week.delete_at(index) if (otherstory[2]-story[2]).empty?
	# 	end
	# end

	

  
  
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
