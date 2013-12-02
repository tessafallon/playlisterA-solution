class Genre
  attr_accessor :name, :songs

  All = []

  def initialize
  #   @songs = []
    All << self
  end

  def self.reset_genres
    All.clear
  end

  def self.all
    All
  end

  def songs
    @songs ||= [] #conditional: if there is already a song array, don't create a new one
  end

  def artists
    songs.collect{|s| s.artist}.uniq
  end

end
