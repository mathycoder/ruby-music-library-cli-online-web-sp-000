require 'pry'

class MusicLibraryController
  
  attr_accessor :path, :importer 
  
  def initialize(path="./db/mp3s")
    @path = path 
    @importer = MusicImporter.new(@path)
    @importer.import 
  end 
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    action = ""
    while action != "exit"
      puts "What would you like to do?"
      action = gets.strip 
      puts "Hi!" if action == "hi"
      self.list_songs if action == "list songs"
      list_artists if action == "list artists"
      list_genres if action == "list genres"
      list_songs_by_artist if action == "list artist"
      list_songs_by_genre if action == "list genre"
      play_song if action == "play song"
      
    end 
  end 
  
  def list_songs 
    counter = 1 
    song_list = Song.all.sort_by{ |song| song.name }
    song_list.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1 
    end 
  end 
  
  def list_artists
    counter = 1 
    artist_list = Artist.all.sort_by{|artist| artist.name}
    artist_list.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1 
    end 
  end 
  
  def list_genres 
    counter = 1 
    genre_list = Genre.all.sort_by{|genre| genre.name}
    genre_list.each do |genre| 
      puts "#{counter}. #{genre.name}"
      counter += 1 
    end 
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    my_artist = gets.strip 
    
    song_list = Song.all.select do |song|
      song.artist.name == my_artist  
    end 
    
    song_list = song_list.sort_by{|song| song.name}

    counter = 1 
    song_list.each do |song| 
      puts "#{counter}. #{song.name} - #{song.genre.name}"
      counter += 1 
    end 
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    my_genre = gets.strip 
    
    song_list = Song.all.select do |song|
      song.genre.name == my_genre   
    end 
    
    song_list = song_list.sort_by{|song| song.name}

    counter = 1 
    song_list.each do |song| 
      puts "#{counter}. #{song.artist.name} - #{song.name}"
      counter += 1 
    end 
  end 
  
  def play_song 
    puts "Which song number would you like to play?"
    song_list = Song.all.sort_by{ |song| song.name }
    number = gets.strip.to_i 
    if number.class == Fixnum && number >0 && number <= song_list.length 
      puts "Playing #{song_list[number-1].name} by #{song_list[number-1].artist.name}"
    end 
  end 
  
end 
