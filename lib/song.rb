require 'pry'
class Song
    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    attr_accessor :name
    attr_reader :genre, :artist
    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.genre = genre
        self.artist = artist
        self.save
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        s = Song.new(name)
        s
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self) if artist.class == Artist
    end

    def genre=(genre)
        @genre = genre
        if genre.class == Genre
            genre.songs << self unless genre.songs.include?(self) 
        end
    end

    def self.find_by_name(name)
        self.all.find{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        song = self.create(filename.split(" - ")[1])
        song.artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
        song.genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".")[0])
        song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end
end 