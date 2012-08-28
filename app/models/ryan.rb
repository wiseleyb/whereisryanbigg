class Ryan < ActiveRecord::Base
  attr_accessible :country, :country_code, :full_name, :gmaps, :latitude, :longitude, :name, :tweet_id

  belongs_to :ryan_location

  default_scope :order => 'tweet_date desc'

  scope :with_location, where("not ryan_location_id is null")
  
  def self.from_tweet(tweets)
  	tweets = [tweets] unless tweets.is_a?(Array)
  	tweets.each do |tweet|
      # puts tweet.to_yaml
      unless tweet.nil?
        r = Ryan.find_or_create_by_tweet_id(tweet.id.to_s)
        r.tweet = tweet.text
        # r.retweet_count = tweet.contributors.retweet_count.to_i
        r.tweet_date = tweet.created_at
        rl = RyanLocation.from_tweet(tweet)
        r.ryan_location_id = rl.id unless rl.nil?
        r.save!
      end
	  end
  end

end


# --- !ruby/object:Twitter::Status
# attrs:
#   created_at: Mon Aug 27 16:43:41 +0000 2012
#   id: 240127455569014784
#   id_str: '240127455569014784'
#   text: ! '@amyhoy Tokyo Vice. [warning: gruesome]'
#   source: <a href="http://tapbots.com" rel="nofollow">Tweetbot for Mac</a>
#   truncated: false
#   in_reply_to_status_id: 240126316240859136
#   in_reply_to_status_id_str: '240126316240859136'
#   in_reply_to_user_id: 627213
#   in_reply_to_user_id_str: '627213'
#   in_reply_to_screen_name: amyhoy
#   user:
#     id: 14506011
#     id_str: '14506011'
#     name: Ryan Bigg
#     screen_name: ryanbigg
#     location: Melbourne, Australia
#     url: http://www.ryanbigg.com
#     description: Award winning super hero published author (Rails 3 in Action). Avid
#       cyclist and hiker. Community manager for Spree Commerce. Views are my own, etc.
#     protected: false
#     followers_count: 5658
#     friends_count: 423
#     listed_count: 264
#     created_at: Thu Apr 24 03:23:53 +0000 2008
#     favourites_count: 314
#     utc_offset: 36000
#     time_zone: Brisbane
#     geo_enabled: true
#     verified: false
#     statuses_count: 35895
#     lang: en
#     contributors_enabled: false
#     is_translator: false
#     profile_background_color: 5D8A8C
#     profile_background_image_url: http://a0.twimg.com/profile_background_images/2503404/Untitled.jpg
#     profile_background_image_url_https: https://si0.twimg.com/profile_background_images/2503404/Untitled.jpg
#     profile_background_tile: true
#     profile_image_url: http://a0.twimg.com/profile_images/1500934941/superman_normal.png
#     profile_image_url_https: https://si0.twimg.com/profile_images/1500934941/superman_normal.png
#     profile_link_color: '000000'
#     profile_sidebar_border_color: '121212'
#     profile_sidebar_fill_color: 00BBFF
#     profile_text_color: '000000'
#     profile_use_background_image: true
#     show_all_inline_media: false
#     default_profile: false
#     default_profile_image: false
#     following: 
#     follow_request_sent: false
#     notifications: 
#   geo: 
#   coordinates: 
#   place:
#     id: 72602030f1acfa9d
#     url: http://api.twitter.com/1/geo/id/72602030f1acfa9d.json
#     place_type: admin
#     name: City of Edinburgh
#     full_name: City of Edinburgh, Scotland
#     country_code: GB
#     country: United Kingdom
#     bounding_box:
#       type: Polygon
#       coordinates:
#       - - - -3.453947
#           - 55.818786
#         - - -3.076103
#           - 55.818786
#         - - -3.076103
#           - 56.017829
#         - - -3.453947
#           - 56.017829
#     attributes: {}
#   contributors: 
#   retweet_count: 0
#   favorited: false
#   retweeted: false