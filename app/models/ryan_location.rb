class RyanLocation < ActiveRecord::Base
  acts_as_gmappable

  serialize :polygon, Array

  has_many :ryans

  default_scope :order => 'updated_at desc'

  def self.from_tweet(tweet)
    unless tweet.place.nil?
      rl = RyanLocation.find_or_create_by_tweet_place_id(tweet.place.id)
      rl.country = tweet.place.country
      rl.country_code = tweet.place.country_code
      rl.full_name = tweet.place.full_name
      rl.name = tweet.place.name
      rl.gmaps = true
      rl.polygon = tweet.place.bounding_box.coordinates
      ll = rl.polygon_to_lat_lng
      rl.latitude = ll["lat"]
      rl.longitude = ll["lng"]
      rl.save!
      return rl
    end
  end

  def polygon_to_hash_arr
    res = []
    self.polygon.first.each do |pl|
      res << {"lng" => pl.first, "lat" => pl.last}
    end
    return res
  end

  def polygon_to_lat_lng
    arr = self.polygon.first.collect {|pl| pl.first}
    lng = arr.inject{ |sum, el| sum + el }.to_f / arr.size
    arr = self.polygon.first.collect {|pl| pl.last}
    lat = arr.inject{ |sum, el| sum + el }.to_f / arr.size
    {"lng" => lng, "lat" => lat}
  end

  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.full_name}"
  end

  def gmaps4rails_title
    "Tweets from #{self.to_s}"
  end

  def gmaps4rails_infowindow
    "<p><b>Last 10 tweets from #{self.to_s}</b></p><ul>" +
    self.ryans.limit(10).collect {|r| "<li>#{r.tweet}</li>" }.join +
    "</ul>"
  end

  # def gmaps4rails_marker_picture
  #   {
  #     "picture" => "/assets/superman.png", 
  #     "width" =>  20,
  #     "height" => 20
  #   }
  # end

  def to_s
    "#{self.full_name}, #{self.country}"
  end

end