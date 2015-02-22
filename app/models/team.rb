
class Team < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  has_many :players, :dependent => :destroy

  # Using the gem "geocoder" that give me some nice stuff for geocode
  # When a create a team with an address (maybe to statium) it asks google about the positions and update the object
  # we can go other way around also
  # see http://www.rubygeocoder.com/
  # http://railscasts.com/episodes/273-geocoder
  #geocoded_by :address
  #after_validation :geocode # auto-fetch latitude, longitude

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  validates :name, presence: true


  # this is called for both as_json and to_xml
  def serializable_hash (options={})
    options = {
      # declare what we want to show
      only: [:id, :name, :nickname, :address, :latitude, :longitude],
      include: [players: {only: [:id, :name]}] # includes players
    }.update(options)


    super(options)
  end

  def self_link
    #  the configuration is set i config/enviroment/{development|productions}.rb
    #  include Rails.application.routes.url_helpers - MVC?
    { :self => "#{Rails.configuration.baseurl}#{team_path(self)}" }
  end


end


