namespace :grab_tasks do

  require 'sanitize'
  require 'awesome_print'
  require 'open-uri'
  require 'selenium-webdriver'
  require 'phantomjs'


  def save_parameters
   @story = Story.new
   @story.source = @raw_parameters[:source]
   @story.area = @raw_parameters[:area]
   @story.title = @raw_parameters[:title]
   @story.url = @raw_parameters[:url]
   @story.modified = @raw_parameters[:modified]
   @story.pic_url = @raw_parameters[:pic_url]
   @story.full_text = @raw_parameters[:full_text]
   @story.save
   p "saved"
  end


  def self.tc_img
    self.attribute("src")
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

     full_text = full_text[0...full_text.rindex("Tags ")]

     pic_url = article_page.css('div.postContent a img').first["src"] rescue pic_url = "assets/music_ally.png"

     @raw_parameters = { :source => "musically",
                        :area => "music",
                        :title => title,
                        :url => url,
                        :modified => modified,
                        :pic_url => pic_url,
                        :full_text => full_text}

      # p @raw_parameters
      save_parameters

   end
 end

task :grab_techcrunch_music => :environment do

    uri =  'http://techcrunch.com/search/music+industry#stq=music industry&stp=1'
    encoded_uri = URI.encode(uri)

    title_selector = "h2.st-result-title a"
    url_selector = "div.st-result-url a"
    img_selector = ".block-content img"
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


task :grab_techcrunch_edu => :environment do

    uri =  'http://techcrunch.com/search/education+language+learning#stq=education language+learning&stp=1'
    encoded_uri = URI.encode(uri)

    title_selector = "h2.st-result-title a"
    url_selector = "div.st-result-url a"
    img_selector = ".block-content img"
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
    doc.xpath('//h1/a').each {|node| titles << node.text }

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

      # p @raw_parameters  
      # p '___________'
      
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
    doc.xpath('//h1/a').each {|node| titles << node.text }

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

      # p @raw_parameters  
      # p '___________'
      
      save_parameters
      i += 1

    end
end

 task :grab_nextweb_edu => :environment do
   response = HTTParty.get('http://thenextweb.com/?s=edtech&fq=&sort=date&order=desc#!y6Yk6
')
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

  private
   def story_params
     params.require(:title, :url).permit(:pic, :modified)
   end

   def valid_date
     self.modified <= Date.today
    end





 end


