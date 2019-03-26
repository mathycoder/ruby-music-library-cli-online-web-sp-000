require 'pry'
require_relative '../lib/concerns/findable'

class Artist 
  extend Concerns::Findable
  attr_accessor :name, :songs 
  @@all = [] 
  
  def self.all 
    @@all
  end 
  
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save 
    new_artist
  end 
  
  def add_song(song)
    if song.artist.nil?
      song.artist = self
      @songs << song 
    end 
  end 
  
  def genres 
    artists_songs = Song.all.select do |song|
      song.artist == self 
    end 
    
    genre_array = []
    artists_songs.each do |song|
      if !(genre_array.include?(song.genre))
        genre_array << song.genre 
      end 
    end 
    genre_array
  end 
  
end 