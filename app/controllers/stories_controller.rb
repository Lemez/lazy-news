class StoriesController < ApplicationController

  def index

    @stories = Story.all
    @stories.each {|story| story.title = story.title.chomp!}
    @source_keys = []

    @stories.latest_fifty.each do |story|
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
    @recent_edsurge = @stories.edsurge.is_education.latest_order

    @music_sources = @stories.is_music.latest_order
    @education_sources = @stories.is_education.latest_order

    @all_by_date = @stories.last_month.latest_order_18
    @all_by_a_to_z = @all_by_date.a_to_z

    @sources = [  
                 # @recent_techcrunch_music,
                 @recent_musically,
                 @recent_venturebeat_music,
                 @recent_cmu, 
                 @recent_edsurge, 
                 # @recent_learnegg,
                 # @recent_techcrunch_edu,
                 # @recent_thenextweb_edu,
                 @recent_venturebeat_edu,
              ]

    # make_histogram renamed to get_top_stories and moved to application controller

    @top_stories_array = ApplicationController.new.get_top_stories

     # ["Google", 8, [994, 983, 941, 930, 927, 926, 909, 898]

    @top_stories_ordered = []
      
    @top_stories_array.each do |array|

        @new_array = []
        @temp_array = []

        array[2].each do |story_id|
          @current_mod_date = Story.where(id:story_id).first.modified
          @new_array << [@current_mod_date, story_id]
        end

        @new_array.sort! { |a,b| a[0] <=> b[0] }
        @new_array.reverse!

        @new_array.each do |pair|
        @temp_array << pair[1]
        
      end
      @top_stories_ordered << [array[0], array[1], @temp_array]

    end



     @top_stories = []

     # turn it into an array with the stories inside

    @top_stories_ordered.each do |array|
      array[2].each do |story_id| 
        @current_story = Story.where(id:story_id) if story_id
        @top_stories << [array[0], array[1], @current_story.first ]
      end
    end

     

    # i = 0
    # while i < @top_stories.length
    #   @top_stories[i][2] = @top_stories[i][2].order("modified DESC")
    #   i += 1
    # end

  end





  private
  def story_params
      params.require(:title, :url, :source).permit(:pic_url, :modified, :full_text, :area)
  end
end
