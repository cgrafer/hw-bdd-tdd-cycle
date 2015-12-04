# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create! movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if page.text.index(e1) > page.text.index(e2)
    fail "#{e1} found before #{e2}"
  end  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rating|
    string = "ratings_" + rating
    
    if uncheck
       step(%Q{I uncheck "#{string}"})
    else
      step(%Q{I check "#{string}"})
    end
  end
  
end



Then /I should see movies rated: (.*)/ do |ratings_string|
  search_string = ratings_string.split(",")
  
  Movie.where(:rating => search_string).each do |movie|
     step(%Q{I should see "#{movie.id}"})
  end
end

Then /I should not see movies rated: (.*)/ do |ratings_string|
  search_string = ratings_string.split(",")

  Movie.where(:rating => search_string).each do |movie|
     step(%Q{I should see "#{movie.id}"})
  end
end



Then /I should see all the movies in movie_steps.rb./ do
  # Make sure that all the movies in the app are visible in the table
  step(%Q{I should see movies rated: G, PG, R, NC-17, PG-13})
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |a_movie, director|
  Movie.find_by_title(a_movie).director == director
end