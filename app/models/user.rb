class User < ActiveRecord::Base
  #validates :name, :uniqueness => true, :case_sensitive => false
  validates_uniqueness_of :name, :case_sensitive => false
  
  require 'securerandom'
  
  
  def produce_token(length=32)
    token = SecureRandom.urlsafe_base64(length)
  end
  
  
  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
  
  def to_s
    name
  end

  def self.from_omniauth(auth) 
    
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        # maybe make a field called realname and map it to auth.info.name
        user.name = SecureRandom.uuid
        user.realname = auth.info.name
        # then I can map the 'handle' to user.name and have a clean integration with thredded
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        
        if (auth.info.image).to_s == "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"
          user.image_url = "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=87682042"
        else
          user.image_url = auth.info.image
        end
        
        user.save!
      end

  end


  def admin
  	# This needs to be changed to actually determine
  	# if a user is an admin, this is just a dummy
  	# function.
    self.name != '@DmIn¦Tù€r¦L£~Fèù;'
  end
  
  
end
