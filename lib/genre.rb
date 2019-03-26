require 'pry'
require_relative '../lib/concerns/findable'

class Genre 
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
    new_genre = Genre.new(name)
    new_genre.save 
    new_genre
  end
  
  def add_song(song)
    if !(@songs.include?(song))
      @songs << song 
    end 
  end 
  
  def artists 
    song_list = Song.all.select do |song|
      song.genre == self 
    end 
    
    artist_list = []
    song_list.each do |song|
      if !(artist_list.include?(song.artist))
        artist_list << song.artist 
      end 
    end 
    artist_list 
  end 
  
end 