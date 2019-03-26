require 'pry'

class MusicImporter
  attr_accessor :path 
  
  def initialize(path)
    @path = path 
  end 
  
  def files 
    path_string = @path + "/*.mp3"
    file_array = Dir[path_string]
    file_array = file_array.collect do |file|
      #binding.pry 
      #file.delete_prefix("./spec/fixtures/mp3s/")
      file = file.split("/")
      file[4]
    end 
  end 
  
  def import 
    self.files.each do |file|
      Song.create_from_filename(file)
    end 
  end 
end 
