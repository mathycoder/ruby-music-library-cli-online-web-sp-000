require 'pry'

class Song 
  #extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = [] 
  
  def self.all 
    @@all
  end 
  
  def initialize(name, artist='none', genre='none')
    @name = name 
    if artist!='none'
      self.artist=(artist) 
    end 
    if genre!='none'
      self.genre=(genre)
    end 
    save 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name)
    new_song = Song.new(name)
    #new_song.save 
    new_song
  end 
  
  def artist=(the_artist)
    @artist = the_artist 
    the_artist.add_song(self)
  end 
  
  def genre=(the_genre)
    @genre = the_genre
    the_genre.add_song(self)
  end 
  
  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name 
    end 
  end 
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil 
      self.create(name)
    else 
      self.find_by_name(name)
    end 
  end 
  
  def self.new_from_filename(filename)
    filename = filename.split(" - ")
    artist = Artist.find_or_create_by_name(filename[0])
    song_title = filename[1] 
    genre = Genre.find_or_create_by_name(filename[2].split(".")[0])
    new_song = Song.new(song_title, artist, genre)
  end 
  
  def self.create_from_filename(filename)
    new_song = Song.new_from_filename(filename)
  end 
  
end 

