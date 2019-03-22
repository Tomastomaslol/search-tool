require 'json'

# Not sure if you wanted me to write some thing smarter or just match strings.
# So I added a 'config' so you can run it in different modes
SLIGTHLY_SMARTER_SEARCH = true

class DataHandler
  attr_reader :type, :parsed_response, :absolute_file_path

  def initialize(type, absolute_file_path)
    @type = type
    @absolute_file_path = absolute_file_path
    @parsed_response = parse_read_file
  end

  def get_type
    type
  end

  def get_all
    parsed_response
  end

  def get_keys
    unique_keys = []
    parsed_response.each do |item|
      item.keys.each do |key|
        unique_keys.push(key) unless unique_keys.include? key
      end
    end
    unique_keys
  end

  def search_for_value(search_term, search_value)
    matched_properties = []
    parsed_response.each do |item|
      if SLIGTHLY_SMARTER_SEARCH
        matched_properties.push(item) if match_search item[search_term], search_value
      else
        matched_properties.push(item) if simple_search item[search_term], search_value
      end
    end
    matched_properties
  end

  private

  def match_search(data_source_value, search_value)
    if data_source_value.is_a?(Array)
      matched_search_results = data_source_value.to_a.select do |map_value|
        map_value.to_s.upcase.include?(search_value.to_s.upcase)
      end
      matched_search_results.any?
    else
      data_source_value.to_s.upcase.include?(search_value.to_s.upcase)
    end
  end

  def simple_search data_source_value, search_value
    data_source_value.to_s == search_value.to_s
  end

  def read_file
    File.read absolute_file_path
  rescue Exception => e
    raise e
  end

  def parse_read_file
    JSON.parse(read_file)
  rescue Exception => e
    raise e
  end
end
