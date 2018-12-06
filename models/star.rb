require_relative("../db/runner")

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name, :fee

  def initialize(options)
    @id = options['id'] if options['id']
    @fee = options['fee'] if options['fee']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save
    sql = "INSERT INTO stars
    (first_name, last_name)
    VALUES
    ($1, $2)
    RETURNING id
    "
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i

  end

  def update
    sql = " UPDATE stars
    SET (first_name, last_name) = ($1,$2) WHERE id = $3
    "
    values = [@first_name, @last_name, @id]
    results = SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM stars
    WHERE id = $1
    "
    values=[id]
    result = SqlRunner.run(sql, values).first
    return self.new(result)
  end

  def movies
    sql = "SELECT movies.* FROM
    movies INNER JOIN castings
    ON castings.movie_id = movies.id
    WHERE star_id = $1"
    values = [@id]
    movies_hash = SqlRunner.run(sql,values)
    return movies_hash.map {|movie| Movie.new(movie)}
  end

end
