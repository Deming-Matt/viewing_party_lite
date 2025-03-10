class MovieService

  def self.conn
    Faraday.new(url:'https://api.themoviedb.org') do |faraday|
      faraday.params["api_key"] = ENV["movie_key"]
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.popular_movies
    page1 = conn.get('/3/movie/popular')
    page2 = conn.get('/3/movie/popular?page=2')
    parse_json(page1)[:results] + parse_json(page2)[:results]
  end

  def self.find_movies(search)
    page1 = conn.get("/3/search/movie?query=#{search}")
    page2 = conn.get("/3/search/movie?query=#{search}&page=2")
    parse_json(page1)[:results] + parse_json(page2)[:results]
  end

  def self.find_movie_by_id(movie_id)
    movie = conn.get("/3/movie/#{movie_id}")
    parse_json(movie)
  end

  def self.cast_for_movie(movie_id)
    movie = conn.get("/3/movie/#{movie_id}/credits")
    parse_json(movie)[:cast]
  end

  def self.reviews_for_movie(movie_id)
    movie = conn.get("/3/movie/#{movie_id}/reviews")
    parse_json(movie)[:results]
  end
end
