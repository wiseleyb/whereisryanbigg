Ryan.destroy_all
RyanLocation.destroy_all

tweets = Twitter.user_timeline("ryanbigg", :count => 200)
Ryan.from_tweet(tweets)

# 15.times do 
# 	tweets = Twitter.user_timeline("ryanbigg", :count => 200, :max_id => Ryan.first.tweet_id)
# 	Ryan.from_tweet(tweets)
# end
