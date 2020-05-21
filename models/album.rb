require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @topping = options['title']
    @quantity = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def save()
    sql = "
    INSERT INTO albums (
      artist_id,
      title,
      genre
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@artist_id, @title, @genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "
    UPDATE albums SET (
      artist_id,
      title,
      genre
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@artist_id, @title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    albums = order_hashes.map { |album| Album.new( album ) }
    return albums
  end

  def self.find(id)
    sql = "SELECT *
    FROM albums
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results.first
    order = PizzaOrder.new(order_hash)
    return order
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

end
