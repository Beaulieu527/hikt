class User < ActiveRecord::Base
    has_secure_password
    has_many :reviews
    has_many :hikes
    
    def slug
        self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end 

    def self.find_by_slug(slug)
        self.all.find{|object| object.slug == slug}
    end 
end 
