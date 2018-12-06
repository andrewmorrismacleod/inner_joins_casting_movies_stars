require_relative("../db/runner")

class Casting

  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

  def initialize(options)
    @id = options['id'] if options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fee = options['fee'].to_i
  end

  def save
    sql = "INSERT INTO castings
    (movie_id, star_id, fee)
    VALUES
    ($1, $2, $3)
    RETURNING id
    "
    values = [@movie_id, @star_id, @fee]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i

  end

  # def update
  #   sql = " UPDATE movies
  #   SET (title, genre) = ($1,$2) WHERE id = $3
  #   "
  #   values = [@title, @genre, @id]
  #   results = SqlRunner.run(sql, values)
  # end
  #
  def self.find_by_id(id)
    sql = "SELECT * FROM castings
    WHERE id = $1
    "
    values=[id]
    result = SqlRunner.run(sql, values).first
    return self.new(result)
  end

end
