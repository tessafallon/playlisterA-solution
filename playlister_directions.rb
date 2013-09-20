def test(title, &b)
  begin
    if b
      result = b.call
      if result.is_a?(Array)
        puts "fail: #{title}"
        puts "      expected #{result.first} to equal #{result.last}"
      elsif result
        puts "pass: #{title}"
      else
        puts "fail: #{title}"
      end
    else
      puts "pending: #{title}"
    end
  rescue => e
    puts "fail: #{title}"
    puts e
  end
end

def assert(statement)
  !!statement
end

def assert_equal(actual, expected)
  if expected == actual
    true
  else
    [expected, actual]
  end
end

# Part 1: Object Models
# Create a new file called test.rb and copy paste everything from this file into that file.
# Create a lib directory and put your other files in there.
# Create a Class for song, artist, and genre. Use an individual file for each class.
# These files should be placed within a lib directory and required on the top of
# any script that utilizes them (including this test script). Once required
# all the tests within this suite should pass.

# Artist Specs
test 'Can initialize an Artist' do
  assert Artist.new
end

test 'An artist can have a name' do
  artist = Artist.new
  artist.name = "Adele"
  assert_equal artist.name, "Adele"
end

test "An artist has songs" do
  artist = Artist.new
  artist.songs = []
  assert_equal artist.songs, []
end

test 'The Artist class can reset the artists that have been created' do
  assert Artist.reset_artists
  assert_equal Artist.count, 0
end

test 'The Artist class can keep track of artists as they are created' do
  Artist.reset_artists
  artist = Artist.new
  assert Artist.all.include?(artist)
end

test 'The Artist class can count how many artists have been created' do
  assert Artist.count
end

test 'artists have songs' do
  artist = Artist.new
  songs = (1..4).collect{|i| Song.new}
  artist.songs = songs

  assert_equal artist.songs, songs
end

test 'An artist can count how many songs they have' do
  artist = Artist.new
  songs = [Song.new, Song.new]
  artist.songs = songs

  assert_equal artist.songs_count, 2
end

test 'a song can be added to an artist' do
  artist = Artist.new
  song = Song.new
  artist.add_song(song)

  assert artist.songs.include?(song)
end

test 'artists have genres' do
  artist = Artist.new
  song = Song.new

  song.genre = Genre.new.tap{|g| g.name = "rap"}
  artist.add_song(song)

  assert artist.genres.include?(song.genre)
end

# Genre Specs
test 'Can initialize a genre' do
  assert Genre.new
end

test 'A genre has a name' do
  genre = Genre.new
  genre.name = 'rap'

  assert_equal genre.name, 'rap'
end

test 'A genre has many songs' do
  genre = Genre.new.tap{|g| g.name = 'rap'}
  [1,2].each do
    song = Song.new
    song.genre = genre
  end

  assert_equal genre.songs.count, 2
end

test 'A genre has many artists' do
  genre = Genre.new.tap{|g| g.name = 'rap'}

  [1,2].each do
    artist = Artist.new
    song = Song.new
    song.genre = genre
    artist.add_song(song)
  end

  assert_equal genre.artists.count, 2
end

test 'A genres Artists are unique' do
  genre = Genre.new.tap{|g| g.name = 'rap'}
  artist = Artist.new

  [1,2].each do
    song = Song.new
    song.genre = genre
    artist.add_song(song)
  end

  assert_equal genre.artists.count, 1
end

# Same behavior as Artists
test 'The Genre class can keep track of all created genres' do
  Genre.reset_genres # You must implement a method like this
  genres = [1..5].collect do |i|
    Genre.new
  end

  assert_equal Genre.all, genres
end

# Extra Credit
# Complete any song test that is pending (undefined).
# The functionality described must still be present to complete the assignment
# so even if you do not complete the pending specs, they must pass in my complete
# test suite. There's no way you'd be able to accomplish the site generation
# without your song class having this functionality, so go ahead and try
# to use assert and assert_equal to write some tests.

test 'Can initialize a song'
test 'A song can have a name'
test 'A song can have a genre'
test 'A song has an artist'

