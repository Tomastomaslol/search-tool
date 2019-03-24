require 'awesome_print'


HEADLINE_BREAK_LINE = " \n#{'-' * 50}\n ".freeze
NO_SEARCH_RESULTS_FOUND = "\nNo search results found\n".freeze

class ReportOutcome
  attr_reader :config

  def initialize(config = false)
    @config = config || default_config
  end

  def print_search_results(output)
    return Kernel.print NO_SEARCH_RESULTS_FOUND if output.empty?

    print_output output
  end

  def print_all_searchable_keys_and_headlines(table_data)
    print_break
    table_data.each do |end_point|
      Kernel.print (HEADLINE_BREAK_LINE +
                   end_point.get_type.capitalize +
                   HEADLINE_BREAK_LINE)
      Kernel.print end_point.get_keys.join("\n")
    end
    print_break
  end

  private

  def print_output(output)
    ap output, config
  end

  def print_break
    Kernel.print "\n\n"
  end

  def default_config
    {
      indent: 0, # Number of spaces for indenting.
      index: false, # Display array indices.
      html: false,  # Use ANSI color codes rather than HTML.
      multiline: true, # Display in multiple lines.
      plain: false, # Use colors.
      raw: false, # Do not recursively format instance variables.
      sort_keys: false, # Do not sort hash keys.
      sort_vars: false, # Sort instance variables.
      limit: false, # Limit arrays & hashes. Accepts bool or int.
      ruby19_syntax: false, # Use Ruby 1.9 hash syntax in output.
      class_name: :class, # Method called to report the instance class name. (e.g. :to_s)
      object_id: false, # Show object id.
      color: {
        args: :pale,
        array: :white,
        bigdecimal: :blue,
        class: :yellow,
        date: :greenish,
        falseclass: :red,
        integer: :blue,
        float: :blue,
        hash: :pale,
        keyword: :cyan,
        method: :purpleish,
        nilclass: :red,
        rational: :blue,
        string: :yellowish,
        struct: :pale,
        symbol: :cyanish,
        time: :greenish,
        trueclass: :green,
        variable: :cyanish
      }
    }
  end
end
