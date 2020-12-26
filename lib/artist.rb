require 'pry'

class Artist
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
        self.save
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        a = Artist.new(name)
        a
    end

    def songs
        @songs
    end

    def add_song(song)
        song.artist = self unless song.artist.class == Artist
        @songs << song unless @songs.include?(song)
    end

    def genres
        self.songs.collect{|song| song.genre}.uniq
    end
end
