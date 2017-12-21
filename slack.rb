class SlackSet
	def send_slack(channel, usernames, message)
	data = {channel: "#{channel}", username: "#{usernames}", text: "#{message}" , icon_emoji: ":ghost:"}.to_json
	#Curl.post(ENV.fetch("SLACK_URL_BOT_ALL_ACCOUNT"), data)
	Curl.post("https://hooks.slack.com/services/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", data)
end
	
end
