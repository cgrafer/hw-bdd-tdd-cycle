require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    fixtures :movies
    describe 'searching by director when valid director' do
        before :each do
            @a_movie = movies(:movie_1)
        end
        
        it 'should call the Model method to search by director ' do 
            #test that the method in the model gets called
            a_movie = movies(:movie_1)
            Movie.should_receive(:search_directors).with(a_movie.director)
            
            #execute the search directors path, passingin a_director
            post :search_directors, {:id => a_movie}
        end
        
        it 'should select the search_directors template for rendering' do 
            #already tested model method above, just stub it here
             a_movie = movies(:movie_1)
            Movie.should_receive(:search_directors).with(a_movie.director)

            #execute the search directors path, passingin a_director
           post :search_directors, {:id => a_movie}

            #test that when controller renders correct haml file
            response.should render_template('search_directors')            
        end
        
        it 'should make the Model search results available to the view' do
        
            #setup array to hold mock return values
             a_movie = movies(:movie_1)
             b_movie = movies(:movie_2)
            fake_results = [a_movie, b_movie]

            #let controller have results of Model methosd set to fake_results
            Movie.should_receive(:search_directors).and_return(fake_results)

            #execute the search directors path, passingin a_director
           post :search_directors, {:id => a_movie}
            
            #now if view tries to get results, make sure they == fake results
            assigns(:movies).should == fake_results
        end
    end
    
    describe 'searching by director when no director' do
        it 'should return to the home page' do
            movie_no_director = movies(:movie_no_director)

            #tell controller to execute search_directors with nil director
            post :search_directors, {:id => movie_no_director}
             
       
            #test that controller goes back to index page when emptycucu director
           response.should redirect_to("/movies")
        end
    end
        
    describe 'deleting movie' do
        it 'should remove the moving from the db' do 
             a_movie = movies(:movie_1)
             Movie.should_receive(:find).with("100").and_return(a_movie)
             
              post :destroy,  {:id => a_movie.id}
                 response.should redirect_to("/movies")
             
        end
    end
    
    describe 'sort by title' do
        it 'should sort by title when title passed' do 
        
            post :index,  {:sort => :title}
        end
        
        it 'should sort by relase data when release date passed' do
            post :index,  {:sort => :release_date}
        
        end
    end
    
    
    describe 'createing moving' do 
        it 'should create a movie in the db' do
        a_movie = movies(:movie_1)

        Movie.should_receive(:create).with(a_movie)
        
        post :create, {:movie => a_movie}
        end
        
    end
    
end
