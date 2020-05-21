require_relative('../db/sql_runner.rb')
require_relative('./album.rb')

class Artist

  attr_reader(:id)
  attr_accessor(:first_name, :last_name)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def albums()
    sql = "SELECT * FROM albums
    WHERE customer_id = $1"
    values = [@id]
    order_hashes = SqlRunner.run(sql, values)
    order_objects = order_hashes.map { |order_hash| Album.new(order_hash) }
    return order_objects
  end

  def save()
    sql = "INSERT INTO artists
    (
    first_name,
    last_name
    )
    VALUES
    (
    $1, $2
    )
    RETURNING *"
    values = [@first_name, @last_name]
    returned_array = SqlRunner.run(sql, values)
    customer_hash = returned_array[0]
    id_string = customer_hash['id']
    @id = id_string.to_i
  end

  def update()
    sql = "UPDATE artists
    SET
    (
      first_name,
      last_name
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artist_hashes = SqlRunner.run(sql)
    artist_objects = customer_hashes.map{|person| Artist.new(person)}
    return artist_objects
  end

  def self.find(id)
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


end
