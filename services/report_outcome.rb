require 'awesome_print'

class ReportOutcome
  attr_reader :config

  def initialize(config = false)
    @config =  config || default_config
  end

  def print(output)
    ap output, config
  end

  def print_all_keys_in_table(table_data)
    table_data.each do |end_point|
      puts "\n#{'-' * 50}"
      puts end_point.get_type.capitalize
      puts "#{'-' * 50}\n"
      puts end_point.get_keys
    end
  end

  private

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
