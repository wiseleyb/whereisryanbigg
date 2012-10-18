class RyanLocation < ActiveRecord::Base
  acts_as_gmappable

  serialize :polygon, Array

  has_many :ryans

  default_scope :order => 'updated_at desc'

  def self.from_tweet(tweet)
    unless tweet.geo.nil? || tweet.geo.coordinates.empty?
      lat = tweet.geo.coordinates.first
      lon = tweet.geo.coordinates.last
      rl = RyanLocation.where(:latitude => lat, :longitude => lon).first
      if rl.nil?
        rl = RyanLocation.new
        # if tweet.place.nil?
          geo = Geokit::Geocoders::GoogleGeocoder3.do_reverse_geocode("#{lat},#{lon}")
          rl.country = geo.country
          rl.country_code = geo.country_code
          rl.full_name = geo.full_address
          rl.name = geo.full_address
        # else
        #   rl.country = tweet.place.country
        #   rl.country_code = tweet.place.country_code
        #   rl.full_name = tweet.place.full_name
        #   rl.name = tweet.place.name
        # end
        rl.gmaps = true
        rl.latitude = lat
        rl.longitude = lon
        rl.save!
      end
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
    # "#{self.full_name}"
    self.full_name.to_s
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
    self.full_name.to_s
  end

end