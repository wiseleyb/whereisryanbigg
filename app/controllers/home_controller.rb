class HomeController < ApplicationController

	def index
		# render :layout => nil
	end

	def update_twitter
		tweets = Twitter.user_timeline("ryanbigg", :count => 200)
		Ryan.from_tweet(tweets)
		redirect_to root_path
	end

end
