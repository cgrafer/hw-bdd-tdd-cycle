require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'search by director' do
      #pre-loaded dummy movies
     # fixtures :movies
      
      it 'should find movies with the same director ' do
      
          
          #make fake movies
          movie1 ={title: 'movie_1', director: 'director_1'}
          movie2 ={title: 'movie_2', director: 'director_2'}
          movie3 ={title: 'movie_3', director: 'director_3'}
          
          
          
          #add fake movies to database
          Movie.create!(movie1)
          Movie.create!(movie2)
          Movie.create!(movie3)
          
          results = Movie.search_directors('director_1')
          
          results.each {|movie| 
            expect(movie.director).to  eq('director_1')
          }
      end
      
      
        it 'should not find movies by different directors ' do
      
          
          #make fake movies
          movie1 ={title: 'movie_1', director: 'director_1'}
          movie2 ={title: 'movie_2', director: 'director_2'}
          movie3 ={title: 'movie_3', director: 'director_3'}
          
          
          
          #add fake movies to database
          Movie.create!(movie1)
          Movie.create!(movie2)
          Movie.create!(movie3)
          
          results = Movie.search_directors('director_1')
          
          results.each {|movie|
            expect(movie.director).to_not eq('director_2')
            
          }
         

      end
      
  end
  
end
