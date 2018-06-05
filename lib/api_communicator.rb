require 'rest-client'
require 'json'
require 'pry'

##OUR HELPER METHODS
def get_request(url)
  #make the web request
  all_characters = RestClient.get(url)
  character_hash = JSON.parse(all_characters)
end

def films_of_character(page_array, character)
  #get an array of hashes of each character. iterate!
  page_array.each do |character_hash|
    #binding.pry
    if character_hash["name"] == character
      #FOUND the right character, return films url array
      return character_hash["films"]
    end
  end
  false
end

#####

def get_character_movies_from_api(character)
  #initial query for first page
  page = get_request('http://www.swapi.co/api/people/')
  film_urls = []
  
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  
  
  while page != nil
    #if character on page
    if films_of_character(page["results"], character)!=false
      #collect an array of the urls of character's films
      film_urls = films_of_character(page["results"], character)
      break
    
    else #character not on page
      #if the page is not the last page yet
      if page["next"] != nil 
        #update the page url, and start loop over again on the new/next page
        page = get_request(page["next"])
      else
        #if character not found on the last page either
        puts "That character was not found"
        break
      end
    end
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  #initialize an empty array where you'll collect film hashes
  films_hash_array = []
  #binding.pry
  #iterate over array of urls and get the page hash for each of those pages.
  film_urls.each do |url|
    #add page hash to the array 
    films_hash_array << get_request(url)
  end

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  
  films_hash_array
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
