require 'rest-client'
require 'json'
require 'pry'


# ----------HELPER METHODS


# --------getting our json file return a hash
def get_json
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

# --------getting array of api links for films of character
def films_array(character_hash, character)
  movie_array =[]
  character_hash["results"].each do |result_element|
     result_element.each do |key, value|
        if value == character
          movie_array.push(result_element["films"])
        end
      end
   end
movie_array
end



def character_name_array(character_hash)
  character_array =[]
  character_hash["results"].each do |result_element|
   result_element.each do |key, value|
      if key == "name"
        character_array.push(result_element["name"])
      end
    end
  end
  character_array
end




# --------returning hash of movie info from a films_array output
def movies_for_character(array_films)
  array_films.collect {|film_url| JSON.parse(RestClient.get(film_url))}
end


# ------------END OF HELPER METHODS



# --------RUNNER METHOD

def get_character_movies_from_api(character)

  character_hash = get_json
  film_info = films_array(character_hash, character).flatten!
  movies_for_character(film_info)
end
# ---------END RUNNER METHOD

#---------ALT METHOD
# all_characters = RestClient.get('http://www.swapi.co/api/people/')
# character_hash = JSON.parse(all_characters)
# -------------getting the list of movies by the given character
# films_array = []
#  character_hash["results"].each do |result_element|
#
#     result_element.each do |key, value|
#
#        if value == character
#          films_array.push(result_element["films"])
#        end
#      end
#   end
# films_array.flatten!
# movies_for_character.collect {|film_url| JSON.parse(RestClient.get(film_url))}
#--------END ALT METHOD



# --------lists out movie titles from results of get_character_movies_from_api(character)
def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  i=1
  films_hash.each do |film_key_element|
    puts "#{i}. #{film_key_element["title"]}"
    i += 1
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
