class Movie < ActiveRecord::Base
	def self.get_all_ratings
		movies = self.all
		ratings = []
		movies.each do|m|
			if !ratings.include? m.rating
				ratings << m.rating
			end
		end
		return ratings
	end
	
	def self.get_movies_by_rating(ratings)
		movies = []
		ratings.each do |r|
			self.find_all_by_rating(r).each do |m|
				movies.push(m)
			end
		end
		return movies
	end

end
