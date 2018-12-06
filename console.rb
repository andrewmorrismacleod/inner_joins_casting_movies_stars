require_relative("models/star")
require_relative("models/movie")
require_relative("models/casting")
require("pry")

movie1 = Movie.new('title' => 'The Killer', 'genre' => 'Sci-fi', 'budget' => 10000000)
movie1.save

movie2 = Movie.new('title' => 'The Terminator 2: Judgement', 'genre' => 'Sci-fi', 'budget' => 100000000)
movie2.save

star1 = Star.new('first_name' => 'Freda', 'last_name' => 'Hamilton')
star1.save

star1.first_name = 'Linda'
star1.update

star2 = Star.new('first_name' => 'Arnold', 'last_name' => 'Schwarzeneggar')
star2.save

movie1.title = 'The Terminator'
movie1.update

casting1 = Casting.new('movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 40000)
casting1.save

casting2 = Casting.new('movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 500000)
casting2.save

casting2 = Casting.new('movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 5000000)
casting2.save

binding.pry
nil
