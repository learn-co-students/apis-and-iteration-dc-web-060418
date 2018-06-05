load "./api_communicator.rb"

def welcome
  # puts out a welcome message here!
  puts "\n"
  puts "Welcome, thanks for visiting the Star Wars Movies by Character search engine."
end

def prompt_user
  puts "\n"
  puts "See the list of valid character names below."
  puts "\n"
  puts character_name_array(get_json)
  puts "\n"
  puts "Please enter a character name from the list or type 'exit' to quit."
end

def get_character_from_user
prompt_user

  # use gets to capture the user's input. This method should return that input, downcased.

  # -----Checks ignoring case sensitivity
  input = gets.chomp.downcase
  character_list = character_name_array(get_json)
  character_list_downcase = character_list.collect {|x| x.downcase}

  if input == "exit"
    puts "May the force be with you!"
  else
    # ------validating input to character list
      until character_list_downcase.include?(input)
        if input == "exit"
          puts "May the force be with you!"
          exit
        else
          puts "\n"
          puts "Character does not exist in our list or doesn't appear as you typed it."
          prompt_user
          input = gets.chomp.downcase
        end
      end
    character_index = character_list_downcase.index(input)
    # -----insures data submition is a match for values in api
    puts "\n"
    puts "#{character_list[character_index]} is featured in:"
    puts "\n"
    show_character_movies(character_list[character_index])
    puts "\n"
    run_method
  end
end


def run_method
get_character_from_user
end


# ------runner method
def start_method
  welcome
  get_character_from_user
end


start_method
