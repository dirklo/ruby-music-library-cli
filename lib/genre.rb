class Genre
    extend Concerns::Findable
    @@all = []

    def self.all
        @@all 
    end

    def self.destroy_all
        @@all = []
    end

    attr_accessor :name

    def initialize(name)
        @name = name
        @songs = []
    end

    def save 
        self.class.all << self
    end

    def self.create(name)
        g = Genre.new(name)
        g.save
        g
    end

    def songs
        @songs
    end

    def artists
        songs.map{|song| song.artist}.uniq
    end
end

