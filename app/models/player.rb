class Player < ActiveRecord::Base
  # includes for urlhelpers
  include Rails.application.routes.url_helpers
  belongs_to :team
  validates :name, presence: true



  def serializable_hash (options={})
    options = {
      only: [:id, :name, :age],
      methods: [:ref, :team_info]
    }.update(options)
    super(options)

  end

  def ref
    #  the configuration is set i config/enviroment/{development|productions}.rb
    #  include Rails.application.routes.url_helpers - MVC?
    { :href => "#{Rails.configuration.baseurl}#{player_path(self)}" }
  end

  # Serialize info from team releation
  def team_info
    team = self.team
    {
      :teamname => team.name,
      :teamid => team.id,
      :link => "#{Rails.configuration.baseurl}#{team_path(team)}"
    }
  end


#Overrideing to_param for messing with th :id-parameter
 # def to_param
 #   "#{self.id+1234}"
 # end

# This is a help function called for translating the id back...This is rather stupid...
 # def self.from_param(param)
 #   find_by_id!(param.to_i-1234)
 # end

end
