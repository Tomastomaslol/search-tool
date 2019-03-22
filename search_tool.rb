require_relative './services/data_handler'
require_relative './services/get_file_path'
require_relative './services/report_outcome'
require_relative './commands/handler'

RELATIVE_PATH_TO_FILES = './data'.freeze
DATA_END_POINTS = %w[users tickets organizations].freeze

def start_application
  all_data_endpoints = DATA_END_POINTS.map do |end_point|
    path = GetFilePath.new end_point, RELATIVE_PATH_TO_FILES
    DataHandler.new end_point, path.absolute_file_path
  end.freeze

  commands = CommandsHandler.new
  report = ReportOutcome.new

  case commands.initial_state
  when 1
    type = commands.select_type_of_search DATA_END_POINTS

    valid_search_terms = all_data_endpoints[(type - 1)].get_keys

    search_term = commands.select_search_term valid_search_terms
    search_value = commands.select_search_value

    found = all_data_endpoints[(type - 1)].search_for_value(search_term, search_value)

    report.print found
  when 2
    report.print_all_keys_in_table all_data_endpoints
  else
    raise 'invalid outcome from initial state'
  end

  commands.re_run_application? ? start_application : Kernel.exit(0)

end
