require "pry"

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end
  
  def self.create
    song = self.new
    @@all << song
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = self.new
    song.name = name
    @@all << song
    song
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if !self.find_by_name(name)
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name}
  end

  def self.new_from_filename(filename)
    song_info = parse_filename(filename)
    song = self.new_by_name(song_info[1])
    song.artist_name = song_info[0]
    song
  end

  def self.create_from_filename(filename)
    song_info = parse_filename(filename)
    song = self.create_by_name(song_info[1])
    song.artist_name = song_info[0]
    song
  end

  def self.destroy_all
    self.all.clear
  end

  private

  def self.parse_filename(filename)
    song_info = filename.split(" - ")
    song_info[1].slice!(".mp3")
    song_info
  end
end
