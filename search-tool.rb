
require 'highline/import'
require 'byebug'
require_relative './services/get_data'
require_relative './services/get_file_path'
require_relative './commands/handler'


RELATIVE_PATH_TO_FILES = './data'.freeze
DATA_END_POINTS = ['organizations', 'tickets', 'users'].freeze

@gg = DATA_END_POINTS.map { |end_point|
  path = GetFilePath.new end_point, RELATIVE_PATH_TO_FILES
  ParseData.new end_point, path.absolute_file_path
}.freeze

commands = CommandsHandler.new
puts @gg[0].get_all

def get_all_searchable
@gg.each { |x|
  #puts "TYPE:" + x.get_type
  #puts x.get_keys 
}
end

def select_type_of_search
  CommandsHandler.new.choose do |menu|
    menu.prompt = "\n Welcome to Zendesk search \n
    Select search option: \n
    * Press 1 to search Zendesk \n
    * Press 2 to view a list of searchable fields \n"
    menu.choice('1') { select_type_of_search }
    menu.choice('2') { get_all_searchable }
    menu.choice('quit') { exit(0) }
    menu.default = { }
  end

end

commands.choose do |menu|
  menu.prompt = "\n Welcome to Zendesk search \n
  Select search option: \n
  * Press 1 to search Zendesk \n
  * Press 2 to view a list of searchable fields \n"
  menu.choice('1') { select_type_of_search }
  menu.choice('2') { get_all_searchable }
  menu.choice('quit') { exit(0) }
  menu.default = { }
end

##intial_state
#exit(0)
