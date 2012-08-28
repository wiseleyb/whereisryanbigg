class HomeController < ApplicationController

	def index

	end

	def update_twitter
		tweets = Twitter.user_timeline("ryanbigg", :count => 200)
		Ryan.from_tweet(tweets)
		tweets = Twitter.search("#withryanbigg", :count => 200)
		Ryan.from_tweet(tweets)
		redirect_to root_path
	end

end
