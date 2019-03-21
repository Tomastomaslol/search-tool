require 'highline/import'

class CommandsHandler
  attr_reader :cli

  def initialize
    @cli = HighLine.new
  end

  def intial_state
    cli.say "\nWelcome to Zendesk search \n
    Select search option: \n
    * Press 1 to search Zendesk \n
    * Press 2 to view a list of searchable fields \n"

    cli.ask("\nPress 1 or 2\n", Integer) { |q| q.in = 1..2 }
  end

  def select_type_of_search(data_end_points)
    cli.say "\n
    Pick one option
    #{data_end_points.map.with_index { |type, index| "#{index + 1}) #{type.capitalize}" }.join(' ')}
    \n"

    valid_range = (1..data_end_points.index(data_end_points.last) + 1).to_a

    cli.ask("Pick one of following values #{valid_range.join(',')}", Integer) { |q| q.in = valid_range }
  end

  def select_search_term(valid_search_terms)
    cli.say "\n
    Enter a valid search term\n
    Valid terms: #{valid_search_terms.join(', ')}
    \n"

    cli.ask("\n Enter a valid term \n") { |q| q.in = valid_search_terms }
  end

  def select_search_value
    cli.ask("\n Search value? \n")
  end

  def re_run_application?
    cli.choose do |menu|
      menu.prompt = "\n
                    Would like to run the application again?\n
                    Enter Y to run again or Q to exit\n
                    \n"
      menu.choice(:Y, :y) { true }
      menu.choices(:Q, :q) { false }
      menu.default = :Y
    end
  end
end
