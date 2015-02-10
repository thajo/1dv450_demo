class Player < ActiveRecord::Base
  include Rails.application.routes.url_helpers 
  belongs_to :team
  
  validates :name, presence: true
  
  
  
  
  def serializable_hash (options={})
    options = {
      only: [:name, :age],
      methods: [:self_link]
    }.update(options)
    super(options)
  end
  
  def self_link
    #  the configuration is set i config/enviroment/{development|productions}.rb
    #  include Rails.application.routes.url_helpers - MVC?
    { :self => "#{Rails.configuration.baseurl}#{player_path(self)}" }
  end

#Overrideing to_param for messing with th :id-parameter 
  def to_param
    "#{self.id+1234}"
  end

# This is a help function called for translating the id back...This is rather stupid...
  def self.from_param(param)
    find_by_id!(param.to_i-1234)
  end
  
end
