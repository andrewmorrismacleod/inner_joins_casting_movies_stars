require_relative("../db/runner")
require_relative("star")
require_relative("casting")

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
  end

  def save
    sql = "INSERT INTO movies
    (title, genre, budget)
    VALUES
    ($1, $2, $3)
    RETURNING id
    "
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i

  end

  def update
    sql = " UPDATE movies
    SET (title, genre, budget) = ($1,$2, $3) WHERE id = $4
    "
    values = [@title, @genre, @budget, @id]
    results = SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM movies
    WHERE id = $1
    "
    values=[id]
    result = SqlRunner.run(sql, values).first
    return self.new(result)
  end

  def stars
    sql = "SELECT stars.* FROM
    stars INNER JOIN castings
    ON castings.star_id = stars.id
    WHERE movie_id = $1"
    values = [@id]
    stars_hash = SqlRunner.run(sql,values)
    return stars_hash.map {|star| Star.new(star)}
  end

  def castings
    sql = "SELECT * FROM castings WHERE movie_id = $1"
    values = [@id]
    casting_hashes = SqlRunner.run(sql,values)
    # return casting_hashes.map {|casting| casting['fee'].to_i}
    return casting_hashes.map {|casting| Casting.new(casting)}
  end

  def remaining_budget
    running_budget = @budget

    casting_array = castings
    for casting in casting_array
      running_budget -= casting.fee
    end

    return running_budget

  end

end
