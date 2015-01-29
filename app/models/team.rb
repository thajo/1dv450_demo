
class Team < ActiveRecord::Base
  
  include Rails.application.routes.url_helpers 
  
  has_many :players, :dependent => :destroy
  
  validates :name, presence: true
   
  
  def serializable_hash (options={})
    options = {
      only: [:name, :nickname],
      include: [:players],
      methods: [:self_link]
    }.update(options)
    super(options)
  end

  def self_link
    #  the configuration is set i config/enviroment/{development|productions}.rb
    #  include Rails.application.routes.url_helpers - MVC?
    { :self => "#{Rails.configuration.baseurl}#{team_path(self)}" }
  end
  
  
  def info
    "#{name} is called #{nickname}"
  end
  
end


