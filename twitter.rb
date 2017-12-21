require 'bundler/setup'
Bundler.require
require 'twitter'
require 'oauth'
require 'time'
require 'json'
require 'net/http'

require './slack'

class TwitterGetTl
	def initialize(to,sc)
		## 何でこれ書いてるんだろう...多分無くても動く気はします ##
		@rest = Twitter::REST::Client.new do |config|
			config.consumer_key = ENV.fetch("TWITTER_API_KEY")
			config.consumer_secret = ENV.fetch("TWITTER_API_SECRET")
			config.access_token = to
			config.access_token_secret = sc
		end

		def timeline
			client.home_timeline(:count => 200).each do |tweet|
				## 作りかけで恐縮ですが...二重配列にRT数などの要素を格納する予定です ##
				@array = Array.new
				@total_array = Array.new
				text = tweet.full_text
				fav = tweet.favorite_count
				rt = tweet.retweet_count
				@weight = fav + rt * 1.5
				@array = [text, fav, rt, @weight]
				p @array
			end
		end

		def test
			id = "A___ki__shiii"   # ツイートを取得したいユーザの ID
			count = 20    # 一度に取得するツイート数. 最大値は 200.

			for num in 1..50 do
				xxx = 51 - num
				tweets = @rest.user_timeline(id, {:count=>count, :page=> xxx})
				puts xxx 
				#tweets.order('id DESC').each do |t|
				tweets.each do |t|
					sla = SlackSet.new
					sla.send_slack("twitter-tl", "User_TL", "----------------------------------------------------------\n#{t.created_at.strftime("%Y/%m/%d %H:%M")} \n #{t.text}\n #{t.favorite_count}")
					puts
					sleep 5
				end
				sleep 100
			end
		rescue => e
			puts "error"
		end

	end
end

app = TwitterGetTl.new("920656133806686208-gi7Z0mxc0ylFA4txjCaZ95tMTQl8FQW","QkilmBgoUBqDRJHR0RiCOPG0JmBe6MKzQsGLip54jZBTX")
app = TwitterGetTl.new("722779054651224068-na3hQwaWJqgIt1vPlgI9enDgJhJ5zCf","zMDRakBVBIVLlo48QNtmwZtHtTotvTq5ITCnzwaZoF2s0")
app.test
