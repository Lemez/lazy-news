namespace :grab_tasks do

  require 'sanitize'
  require 'awesome_print'
  require 'open-uri'
  require 'selenium-webdriver'
  require 'phantomjs'

  def set_up_parameters
    @imgs = []
    @titles = []
    @urls = []
    @full_texts = []
    @modifieds = []
  end


  def save_parameters

    @story = Story.where(:url => @raw_parameters[:url]).first

    if @story.nil?
      @story = Story.where(:url => @raw_parameters[:url]).first_or_create
      @story.source = @raw_parameters[:source]
      @story.area = @raw_parameters[:area]
      @story.title = @raw_parameters[:title]
      @story.url = @raw_parameters[:url]
      @story.modified = @raw_parameters[:modified]

    else
      p "Story #{@raw_parameters[:title]} already exists"

      if @raw_parameters[:pic_url]
        @story.pic_url = @raw_parameters[:pic_url]
      else
        @story.pic_url = "breaking_news.png"
      end
      @story.save!

    end

   #  if @raw_parameters[:full_text]
   #  @story.full_text = @raw_parameters[:full_text]
   # else
   #  @story.full_text = ""
   # end

   p "saved"
  end

  def self.tc_img
    self.attribute("src")
  end


  desc "execute all"
  task :execute_all => :environment do

    p "running musically"
    Rake::Task["grab_tasks:grab_musically"].invoke

    p "running vb music"
    Rake::Task["grab_tasks:grab_venturebeat_music"].invoke

    p "running vb edu"
    Rake::Task["grab_tasks:grab_venturebeat_edu"].invoke

    p "running cmu music"
    Rake::Task["grab_tasks:grab_cmu"].invoke

    p "running edsurge edu"
    Rake::Task["grab_tasks:grab_edsurge"].invoke

    # p "running tc music"
    # Rake::Task["grab_tasks:grab_techcrunch_music"].invoke

    # p "running tc edu"
    # Rake::Task["grab_tasks:grab_techcrunch_edu"].invoke
  end


  task :grab_musically => :environment do
     response = HTTParty.get('http://musically.com/features-2/')
     doc = Nokogiri::HTML(response)

     doc.css('div.oneThird').each do |item|


       title = item.first_element_child().content

       title = title.gsub! /\t*\n*/,''.squeeze(" ").strip
       title = title.strip
       modified_line = item.first_element_child().next_element().content
       modified = modified_line[0...modified_line.index("by") -1].to_date
       #pic_url = item.first_element_child().next_element().next_element()["src"]
    
       url = item.first_element_child().next_element().next_element().next_element().first_element_child().next_element().first_element_child()['href']
       article_url = HTTParty.get(url)
       article_page = Nokogiri::HTML(article_url)
       full_text = ''
       article_page.css('div.postContent p').each do |para|
         full_text += para.content
       end

       p full_text
       # full_text = full_text[0...full_text.rindex("Tags ")] rescue full_text[0...full_text.rindex("Posted in")]

       pic_url = article_page.css('div.postContent a img').first["src"] rescue pic_url = "assets/music_ally.png"

       @raw_parameters = { :source => "musically",
                          :area => "music",
                          :title => title,
                          :url => url,
                          :modified => modified,
                          :pic_url => pic_url,
                          :full_text => full_text
                        }

        # p @raw_parameters
        save_parameters

     end
  end

  task :grab_techcrunch_music => :environment do

      uri =  'http://techcrunch.com/search/music#stq=music&stp=1'
      encoded_uri = URI.encode(uri)

      title_selector = "h2.st-result-title a"
      url_selector = "h2.st-result-title a"
      img_selector = ".article-entry img"
      date_selector = ".byline time"

      imgs = []
      titles = [] 
      urls = []
      modifieds = [] 
      texts = [] 
      i = 0


      driver = Selenium::WebDriver.for :firefox
      driver.get(uri)
      driver.switch_to.default_content

      # get image
      items = driver.find_elements(:css, img_selector)
      items.each {|x| imgs << x.attribute("src") if x.attribute("src") }
      #items.each {|x| p x.tc_img unless x.tc_img.nil?}
    
      # get urls 
      items = driver.find_elements(:css, url_selector)  
      items.each {|x| urls << x.attribute("href") }
   
      # get modifieds   
      items = driver.find_elements(:css, date_selector)
      items.each {|x| modifieds << x.text.to_date }

       # get titles 
      items = driver.find_elements(:css, title_selector)
      items.each {|x| titles << x.text }
   
      # get full texts  
      urls.each do |url|
        @text = []
        response = HTTParty.get(url)
        doc = Nokogiri::HTML(response)
        
        doc.css('.article-entry p').each { |para|  @text << para.content }
        
        texts << @text
      end


      # loop through elements and recompile stories
      while i < titles.length

        @raw_parameters = { :source => "techcrunch",
                          :area => "music",
                         :title => titles[i],
                         :url => urls[i],
                         :modified => modifieds[i],
                         :pic_url => imgs[i],
                         :full_text => texts[i].join('')
                       }

         p @raw_parameters
         p '___________'
        
         save_parameters
        i += 1

      end

      driver.quit
  end

  task :grab_techcrunch_edu => :environment do

      uri =  'http://techcrunch.com/search/"language"#stq="language"&stp=1'
      encoded_uri = URI.encode(uri)

      title_selector = "h2.st-result-title a"
      url_selector = "h2.st-result-title a"
      img_selector = ".article-entry img"
      date_selector = ".byline time"

      imgs = []
      titles = [] 
      urls = []
      modifieds = [] 
      texts = [] 
      i = 0


      driver = Selenium::WebDriver.for :firefox
      driver.get(uri)
      # driver.switch_to.default_content
      driver.find_element(:id,'recent-sort-selector').click

      # get image
      items = driver.find_elements(:css, img_selector)
      items.each {|x| imgs << x.attribute("src") if x.attribute("src") }
      #items.each {|x| p x.tc_img unless x.tc_img.nil?}
    
      # get urls 
      items = driver.find_elements(:css, url_selector)  
      items.each {|x| urls << x.attribute("href") }
   
      # get modifieds   
      items = driver.find_elements(:css, date_selector)
      items.each {|x| modifieds << x.text.to_date }

       # get titles 
      items = driver.find_elements(:css, title_selector)
      items.each {|x| titles << x.text }
   
      # get full texts  
      urls.each do |url|
        @text = []
        response = HTTParty.get(url)
        doc = Nokogiri::HTML(response)
        
        doc.css('.article-entry p').each { |para|  @text << para.content }
        
        texts << @text
      end

      # loop through elements and recompile stories
      while i < titles.length

        @raw_parameters = { :source => "techcrunch",
                          :area => "education",
                         :title => titles[i],
                         :url => urls[i],
                         :modified => modifieds[i],
                         :pic_url => imgs[i],
                         :full_text => texts[i].join("")}

        p @raw_parameters
        p '___________'
        
        save_parameters
        i += 1

      end

      driver.quit
  end

  task :grab_venturebeat_edu => :environment do
     response = HTTParty.get('http://venturebeat.com/category/education/')
     doc = Nokogiri::HTML(response)
     xdoc = doc.css('article.post div a')
     ydoc = doc.css('article.post')

      # ap xdoc.search('img').map{ |a| [a['src'], a.text] }[0, 9]
          imgs = []
          xdoc.xpath("//*[contains(@class, 'river')]").each {|node| imgs << node["src"] if node["src"]  }

          @url = ''
          urls = []
          doc.css('article.post div a').each do |item|
          if item['rel'] == 'bookmark'
            if @url != item['href']
              @url = item['href']
              urls << @url
            end
          end
        end
       
         titles = []
          xdoc.xpath('//h2/a').each {|node| titles << node.text }

          modifieds = []
          doc.xpath("//*[contains(@class, 'the-time')]").each {|node| modifieds << node.text.to_date }

          fulltexts=[]
          urls.each do |article|
            text = []
            doc = Nokogiri::HTML(HTTParty.get(article))
            doc.xpath("//*[contains(@class, 'post-content')]/p").each {|node| text << node.text }
            fulltexts << text.join(" ")
          end

            # p titles.length
            # p urls.length
            # p modifieds.length
            # p imgs.length # images getting far too many inputs
            # p fulltexts.length


          i = 0
           while i < titles.length

            @raw_parameters = { :source => "venturebeat",
                              :area => "education",
                             :title => titles[i],
                             :url => urls[i],
                             :modified => modifieds[i],
                             :pic_url => imgs[i],
                             :full_text => fulltexts[i]}

            p @raw_parameters  
            p '___________'
            
            save_parameters
            i += 1

          end
  end 

  task :grab_venturebeat_music => :environment do
     response = HTTParty.get('http://venturebeat.com/tag/music/')
     doc = Nokogiri::HTML(response)
     xdoc = doc.css('article.post div a')
     ydoc = doc.css('article.post')

      # ap xdoc.search('img').map{ |a| [a['src'], a.text] }[0, 9]
      imgs = []
      xdoc.xpath("//*[contains(@class, 'river')]").each {|node| imgs << node["src"] if node["src"]  }

      @url = ''
      urls = []
      doc.css('article.post div a').each do |item|
        if item['rel'] == 'bookmark'
          if @url != item['href']
            @url = item['href']
            urls << @url
          end
        end
      end

     titles = []
      doc.xpath('//h2/a').each {|node| titles << node.text }

      modifieds = []
      doc.xpath("//*[contains(@class, 'the-time')]").each {|node| modifieds << node.text.to_date }

      fulltexts=[]
      urls.each do |article|
        text = []
        doc = Nokogiri::HTML(HTTParty.get(article))
        doc.xpath("//*[contains(@class, 'post-content')]/p").each {|node| text << node.text }
        fulltexts << text.join(" ")
      end

        # p titles.length
        # p urls.length
        # p modifieds.length
        # p imgs.length # images getting far too many inputs
        # p fulltexts.length


      i = 0
       while i < titles.length

        @raw_parameters = { :source => "venturebeat",
                          :area => "music",
                         :title => titles[i],
                         :url => urls[i],
                         :modified => modifieds[i],
                         :pic_url => imgs[i],
                         :full_text => fulltexts[i]}

         p @raw_parameters  
         p '___________'
        
        save_parameters
        i += 1

      end
  end


  task :grab_cmu => :environment do
    response = HTTParty.get('http://www.completemusicupdate.com/topstories/')
     doc = Nokogiri::HTML(response)
      set_up_parameters

      doc.xpath("//*[contains(@class, 'srp-thumbnail-box')]/a/img").each {|node| @imgs << node["src"] if node["src"]}
      doc.xpath("//*[contains(@class, 'srp-post-title')]/a").each {|node| @urls << node["href"] if node["href"]}
      doc.xpath("//*[contains(@class, 'srp-post-title')]/a").each {|node| @titles << node.text if node.text}
      doc.xpath("//*[contains(@class, 'srp-widget-date')]").each {|node| @modifieds << node.text if node.text}

       i = 0
       while i < @titles.length

        @raw_parameters = { :source => "cmu",
                          :area => "music",
                         :title => @titles[i],
                         :url => @urls[i],
                         :modified => @modifieds[i],
                         :pic_url => @imgs[i],
                         # :full_text => fulltexts[i]
                       }

         p @raw_parameters  
         p '___________'
        
        save_parameters
        i += 1
      end

  end

  #work in progress 
  task :grab_businessweek_music => :environment do
     response = HTTParty.get(' http://www.businessweek.com/search?q=music+business')
     doc = Nokogiri::HTML(response)
     xdoc = doc.css('.column_container .tracked')
     ydoc = doc.css('article.post')

      # ap xdoc.search('img').map{ |a| [a['src'], a.text] }[0, 9]
      imgs = []
      xdoc.xpath('//*[contains(concat( " ", @class, " " )), concat( " ", "lazy", " " ))]').each {|node| imgs << node["src"] if node["src"]  }
      p imgs

        #   @url = ''
        #   urls = []
        #   doc.css('article.post div a').each do |item|
        #   if item['rel'] == 'bookmark'
        #     if @url != item['href']
        #       @url = item['href']
        #       urls << @url
        #     end
        #   end
        # end

        #  titles = []
        #   doc.xpath('//h1/a').each {|node| titles << node.text }

        #   modifieds = []
        #   doc.xpath("//*[contains(@class, 'the-time')]").each {|node| modifieds << node.text.to_date }

        #   fulltexts=[]
        #   urls.each do |article|
        #     text = []
        #     doc = Nokogiri::HTML(HTTParty.get(article))
        #     doc.xpath("//*[contains(@class, 'post-content')]/p").each {|node| text << node.text }
        #     fulltexts << text.join(" ")
        #   end

        #     # p titles.length
        #     # p urls.length
        #     # p modifieds.length
        #     # p imgs.length # images getting far too many inputs
        #     # p fulltexts.length


        #   i = 0
        #    while i < titles.length

        #     @raw_parameters = { :source => "venturebeat",
        #                       :area => "music",
        #                      :title => titles[i],
        #                      :url => urls[i],
        #                      :modified => modifieds[i],
        #                      :pic_url => imgs[i],
        #                      :full_text => fulltexts[i]}

        #     # p @raw_parameters  
        #     # p '___________'
            
        #     save_parameters
        #     i += 1

        #   end
  end

  task :grab_edsurge => :environment do
    root = "https://www.edsurge.com"
    response = HTTParty.get(root)
    doc = Nokogiri::HTML(response)
    # xdoc = doc.search("[text()*='Trending Articles']")
    doc.css('div.post__numbered-post-content')[0..3].each do |path|

      title = path.at('span.generic-item__name').children.text
      url = "#{root}#{path.parent.parent["href"]}"
      modified = url[root.length+3...root.length+13]

      response2 = HTTParty.get(url)
      doc2 = Nokogiri::HTML(response2)

      pic_url = doc2.css("div.post__cover-image img").first["src"]
      full_text = doc2.css("div.textblock p").text

         @raw_parameters = { :source => "edsurge",
                          :area => "education",
                         :title => title,
                         :url => url,
                         :modified => modified,
                         :pic_url => pic_url,
                         :full_text => full_text
                       }

        p @raw_parameters
        p '___________'
        
        save_parameters

       
    end


    links = []
    titles = []

    # xdoc.xpath("//*[contains(@class, 'generic-item')]").each{|a| links << a["href"] if a["href"]}
    # xdoc.xpath("//*[contains(@class, 'generic-item__name')]").each{|a| titles << a.content if a.content}
  
    # links.length.times do |i|
    #   p "Link: #{links[i]}; \n Title: #{titles[i]}"
    # end
 

  end

  task :grab_nextweb_edu => :environment do
     response = HTTParty.get('http://thenextweb.com/?s=edtech&fq=&sort=date&order=desc#!y6Yk6')
     doc = Nokogiri::HTML(response)
     xdoc = doc.css('div.article-listing')

      # ap xdoc.search('img').map{ |a| [a['src'], a.text] }[0, 9]
      imgs = []
      xdoc.xpath("//*[contains(@class, 'wp-post-image')]").each {|node| imgs << node["src"] if node["src"]  }

      urls = []
      titles = []
      xdoc.xpath("//*[contains(@class, 'post-link')]").each do |node|
        urls << node["href"] if !urls.include?(node["href"])  
        title = node.text.strip
        titles << title if !urls.include?(title) and title.length>0 
      end

      modifieds = []
      fulltexts = []

      urls.each do |url|
        text = []
        index = 0
        article = Nokogiri::HTML(HTTParty.get(url))
        newdoc = article.css('div.article-head')
        newdoc.xpath("//*[contains(@class, 'article-date')]").each do |node|
          if node.text
            date = node.text
            i = date.index("'")
            formatted = date[0...i] + '20' + date[i+1..-1]
            modifieds << formatted.to_date  
          end
        end
        # body = newdoc.xpath("//*[contains(@itemprop, 'articleBody')] and not(@class,'headline')")
        # body.xpath("//p").each {|node| text << node.text }
        newdoc.xpath("//p[not(@class)]").each {|node| text << node.text }

        text = text.join(" ").strip
        fulltexts << text[0...(text.index("\n\t"))]

      end

      i = 0
       while i < titles.length

        @raw_parameters = { :source => "thenextweb",
                          :area => "education",
                         :title => titles[i],
                         :url => urls[i],
                         :modified => modifieds[i],
                         :pic_url => imgs[i],
                         :full_text => fulltexts[i]}

        p @raw_parameters  
        p '___________'
        
        save_parameters
        i += 1

       end
  end 

  task :grab_learnegg => :environment do
     response = HTTParty.get(' http://learnegg.com/')
     doc = Nokogiri::HTML(response)
     xdoc = doc.css('div.post')

      # ap xdoc.search('img').map{ |a| [a['src'], a.text] }[0, 9]
      imgs = []

      if xdoc.xpath("//img")[2..-1] != nil
        xdoc.xpath("//img")[2..-1].each {|node| imgs << node["src"] if node["src"]  }
      else
        imgs << "assets/learnegg.png"
      end

      urls = []
      titles = []
      xdoc.xpath("//*[contains(@rel, 'bookmark')]").each do |node|
        urls << node["href"] if !urls.include?(node["href"])  
        title = node.text.strip
        titles << title if !urls.include?(title) and title.length>0 
      end

      # modifieds = []
      # fulltexts = []

      #  urls.each do |url|
      #   text = []
      #   index = 0
      #   article = Nokogiri::HTML(HTTParty.get(url))
      #   newdoc = article.css('div.grid')
      #   newdoc.xpath("//*[contains(@itemprop, 'datePublished')]").each do |node|
      #       modifieds << node.text.to_date if node.text 
      #     end

      i = 0
      while i < titles.length

        @raw_parameters = { :source => "learnegg",
                          :area => "education",
                         :title => titles[i],
                         :url => urls[i],
                         :modified => nil,
                         :pic_url => imgs[i],
                         :full_text => nil}

        p @raw_parameters  
        p '___________'
        
        save_parameters
        i += 1

      end
  end

  private
    def story_params
      params.require(:title, :url).permit(:pic, :modified)
    end

    def valid_date
      self.modified <= Date.today
    end
end

 # inside the app, bundle exec rake grab_tasks:grab_venturebeat_music


