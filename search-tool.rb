
require 'highline/import'
require 'byebug'
require_relative './services/get_data'
require_relative './services/get_file_path'
require_relative './commands/handler'


RELATIVE_PATH_TO_FILES = './data'.freeze
DATA_END_POINTS = ['users', 'tickets', 'organizations'].freeze

@gg = DATA_END_POINTS.map { |end_point|
  path = GetFilePath.new end_point, RELATIVE_PATH_TO_FILES
  ParseData.new end_point, path.absolute_file_path
}.freeze

commands = CommandsHandler.new

def get_all_searchable
@gg.each { |x|
  puts "TYPE:" + x.get_type
  puts x.get_keys 
}
end

case commands.intial_state
  when 1
   type = commands.select_type_of_search DATA_END_POINTS  
   valid_search_terms = @gg[(type - 1)].get_keys
   search_term = commands.select_search_term valid_search_terms
   search_value = commands.select_search_value

   found = @gg[(type - 1)].search_for_value(search_term, search_value)
   puts found
  when 2
    get_all_searchable
  else
    puts "noodldkdkdkdkdbs"
end

##intial_state
#exit(0)
