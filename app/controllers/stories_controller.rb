class StoriesController < ApplicationController

  def index

     @source_keys = []
     Story.latest_order.each do |story|
      @source_keys << story.area unless @source_keys.include?(story.area)
     end


    @recent_musically = Story.musically.latest_order
    @recent_techcrunch_edu = Story.techcrunch.is_education.latest_order
    @recent_techcrunch_music = Story.techcrunch.is_music.latest_order
    @recent_venturebeat = Story.venturebeat.is_education.latest_order


    @music_sources = Story.is_music.latest_order
    @education_sources = Story.is_education.latest_order


    @all_by_date = Story.ordered.limit(50)
    @all_by_a_to_z = Story.a_to_z.limit(50)

    @sources = [ @recent_musically,      
                 @recent_techcrunch_music,
                 @recent_techcrunch_edu,
                 @recent_venturebeat
              ]

  

    # make_histogram

  end



  def make_histogram
      #   @words = Array.new

  #   @sources.each do |source|
  #     source.each do |story|
  #       story = story.full_text.split(" ") rescue story = story.title.split(" ")
  #       story.each do |word|
  #         @words.push(word) unless word[-2..-1] == "/'s"
  #         @words.push(word[0...-2]) if word[-2..-1] == "/'s"
  #       end
  #     end
  #   end
 
  # @wf = Hash.new(0)
  # @histogram = Hash.new(0)
  # @words.each { |word| @wf[word] += 1 }
  # @wf = @wf.sort_by{|k, v| v}.reverse

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

  private
  def story_params
      params.require(:title, :url, :source).permit(:pic_url, :modified, :full_text, :area)
  end
end
