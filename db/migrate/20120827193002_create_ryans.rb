class CreateRyans < ActiveRecord::Migration
  def change

    create_table :ryans do |t|
      t.string :tweet_id
      t.string :tweet
      # t.integer :retweet_count, :default => 0
      t.datetime :tweet_date
      t.references :ryan_location
      
      t.timestamps
    end

    add_index "ryans", ["tweet_id"]

    create_table :ryan_locations do |t|
      t.string :tweet_place_id
      t.string :name
      t.string :full_name
      t.string :country_code
      t.string :country
      t.text :polygon
      t.float :longitude
      t.float :latitude
      t.boolean :gmaps

      t.timestamps
    end

    add_index "ryan_locations", ["tweet_place_id"]

  end
end
