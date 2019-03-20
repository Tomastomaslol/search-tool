
require 'highline/import'

class CommandsHandler

  attr_reader :cli

    def initialize
     @cli = HighLine.new
    end

    def intial_state
    end

    def select_type_of_search
      cli.choose do |menu|
        menu.prompt = "\n Select 1/ Users 2/ Tickets 3/ Organizations \n"
        menu.choice('1') { select_search_term }
        menu.choice('2') { select_search_term }
        menu.choice('3') { select_search_term }
        menu.default = { }
      end
    end

    def select_search_term
      cli.ask " \n Search term? \n " 
    end

    
    def enter_search_value
      cli.ask " \n Search value?  \n" 
    end

end  