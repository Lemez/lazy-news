class StoriesController < ApplicationController

  #need to get our user controller directions into our stories controller


  def latest
    @stories = Story.scoped
    @all_by_date = @stories.where.not(source:'rollingstone').order(:modified).last_month
  end

  def music

    @stories = Story.all.uniq(&:url)

    @recent_musically = @stories.musically.latest_order
    @recent_cmu = @stories.cmu.latest_order
    @recent_venturebeat_music = @stories.venturebeat.is_music.latest_order
    @recent_mbw = @stories.mbw.latest_order
    @recent_rollingstone = @stories.rollingstone.latest_order
    @recent_wired = @stories.wired.latest_order
    @recent_mit = @stories.mit.latest_order

       @sources = [  
                 @recent_musically,
                 @recent_wired,
                 @recent_mit,
                 @recent_mbw,
                 @recent_rollingstone,
                 @recent_venturebeat_music,
                 @recent_cmu
               ]


  end

    # make_histogram renamed to get_top_stories and moved to application controller

    # @top_stories_array = ApplicationController.new.get_top_stories

    #  # ["Google", 8, [994, 983, 941, 930, 927, 926, 909, 898]

    # @top_stories_ordered = []
      
    # @top_stories_array.each do |array|

    #     @new_array = []
    #     @temp_array = []

    #     array[2].each do |story_id|
    #       @current_mod_date = Story.where(id:story_id).first.modified
    #       @new_array << [@current_mod_date, story_id]
    #     end

    #     @new_array.sort! { |a,b| a[0] <=> b[0] }
    #     @new_array.reverse!

    #     @new_array.each do |pair|
    #     @temp_array << pair[1]
        
    #   end
    #   @top_stories_ordered << [array[0], array[1], @temp_array]

    # end



    #  @top_stories = []

    #  # turn it into an array with the stories inside

    # @top_stories_ordered.each do |array|
    #   array[2].each do |story_id| 
    #     @current_story = Story.where(id:story_id) if story_id
    #     @top_stories << [array[0], array[1], @current_story.first ]
    #   end
    # end

     

    # # i = 0
    # # while i < @top_stories.length
    # #   @top_stories[i][2] = @top_stories[i][2].order("modified DESC")
    # #   i += 1
    # # end

  def mailer
    
  end





  private
  def story_params
      params.require(:title, :url, :source).permit(:pic_url, :modified, :full_text, :area)
  end
end
