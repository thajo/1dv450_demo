class Team < ActiveRecord::Base
  has_and_belongs_to_many :matches
  has_many :players, :dependent => :destroy
  
  validates :name, presence: true
   
  
  def info
    "#{name} is called #{nickname}"
  end
  
end


