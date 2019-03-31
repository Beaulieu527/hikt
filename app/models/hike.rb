class Hike < ActiveRecord::Base

    has_many :reviews

    def slug
        self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end 

    def self.find_by_slug(slug)
        self.all.find{|object| object.slug == slug}
    end 

    def self.import(data)
        trails = data["trails"].map do |hash|
            hike = Hike.new
            attributes = hash.select do |key, value|
                hike.respond_to?(key)
            end
            hike.update(attributes)
            hike
        end
    end
end
