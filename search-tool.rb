
require 'highline/import'
require 'byebug'
require_relative './services/get_data'
require_relative './commands/handler'

SEARCHABLE_PROPERTIES = ['organizations', 'tickets', 'users'].freeze
@gg = SEARCHABLE_PROPERTIES.map {|prop| ParseData.new prop }.freeze

commands = CommandsHandler.new
puts @gg[0].get_all

def get_all_searchable
@gg.each { |x|
  puts "TYPE:" + x.get_type
  puts x.get_keys 
}
commands.intial_state
end


commands.intial_state


##intial_state
#exit(0)
