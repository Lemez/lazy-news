require 'chatterbot/dsl'

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
		tweetstring = "#{story.source.upcase}: #{story.title}: #{story.url} ##{HASHTAGS.sample.downcase}"
		tweet tweetstring
		p "#{tweetstring} tweeted!"
	end
end
