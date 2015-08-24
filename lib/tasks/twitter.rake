require 'chatterbot/dsl'
require 'twitter'

HANDLES = {
	'wired' => '@WiredUK',
	'musicbusinessworldwide' => '@musicbizworld',
	'mit' => "@techreview",
	'venturebeat' => "@VentureBeat",
	'musically' => "@MusicAlly",
	'rollingstone' => "@RollingStone",
	'cmu' => "@cmu"
	}

HASHTAGS = %w(Affection Anger Angst Anguish Annoyance Anxiety Apathy Arousal Awe Boredom Confidence Contempt Contentment Courage Curiosity Depression Desire Despair Disappointment Disgust Distrust Dread Ecstasy Embarrassment Envy Euphoria Excitement Fear Frustration Gratitude Grief Guilt Happiness Hatred Hope Horror Hostility Hurt Hysteria Indifference Interest Jealousy Joy Loathing Loneliness Love Lust Outrage Panic Passion Pity Pleasure Pride Rage Regret Relief Remorse Sadness Satisfaction Schadenfreude Self-confidence Shame Shock Shyness Sorrow Suffering Surprise Trust Wonder Worry Zeal Zest)

namespace :bot do

	consumer_key ENV['tw_consumer_key']
	consumer_secret ENV['tw_consumer_secret'] 
	secret ENV['tw_token_secret'] 
	token ENV['tw_access_token']

	desc "run_bot"
	task :tweet => :environment do

		exclude bad_words
		story = Story.last_week.sample
		handle = HANDLES[story.source]
		tweetstring = "#{story.title}: #{story.url} ##{HASHTAGS.sample.downcase}"
		tweet tweetstring
		p "#{tweetstring} tweeted!"
	end

	desc "breaking_bot"
	task :tweetstory, [:title, :url, :pic] => :environment do |t, args|
		story = Story.last_week.sample
		title = args[:title] || story.title
		url = args[:url] || story.url
		pic = args[:pic] || story.pic_url
		tweetstring = "#{title}: #{url} ##{HASHTAGS.sample.downcase}"
		tweet tweetstring
		p "#{Time.now}: #{tweetstring} tweeted!"
	end

	desc "favourite_bot"
	task :fave => :environment do
		twitter_init
		@client.search("startup").take(3).collect do |tweet|
				favorite tweet
		end
	end

	desc "follow"
	task :follow => :environment do
		twitter_init
		random = 1 + rand(10)
		@client.search("music").take(random).collect do |tweet|
				follow tweet.user.id
				p "followed #{tweet.user.name}"
		end
	end

	desc "followers"
	task :followers => :environment do
		twitter_init

		@client.followers.each {|f| p f.name}
	end

	desc "mentions"
	task :replies => :environment do
		replies do |tweet|
			p tweet
		end
	end

end

def twitter_init
	@client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV['tw_consumer_key']
	  config.consumer_secret     = ENV['tw_consumer_secret'] 
	  config.access_token        = ENV['tw_access_token']
	  config.access_token_secret = ENV['tw_token_secret']  
	end
end
