
# Not sure if you wanted me to write some thing smarter or just match strings.
# So I added a 'config' so you can run the application in different modes
SLIGHTLY_SMARTER_SEARCH = true

class Search
  attr_reader :parsed_response, :search_term, :search_value

  def initialize(parsed_response, search_term, search_value)
    @parsed_response = parsed_response
    @search_term = search_term
    @search_value = search_value
    validate_given_input!
  end

  def find_matching_terms
    matched_properties = []
    parsed_response.each do |item|
      if SLIGHTLY_SMARTER_SEARCH
        matched_properties.push(item) if match_search item[search_term]
      else
        matched_properties.push(item) if simple_search item[search_term]
      end
    end
    matched_properties
  end

  private

  def valid_parsed_response?
    return false unless parsed_response.is_a?(Array)

    parsed_response.all? { |item| item.is_a?(Hash) }
  end

  def validate_given_input!
    errors = []
    errors.push("search_term: '#{search_term}'") unless search_term.respond_to?(:to_str)
    errors.push("search_value: '#{search_value}'") unless search_value.respond_to?(:to_s)
    errors.push("parsed_response: '#{parsed_response}'") unless valid_parsed_response?
    raise "Invalid input for Search Service #{errors.join(', ')}" if errors.any?
  end

  def match_search_result_to_type_array(data_source_value)
    data_source_value.to_a.select do |map_value|
      map_value.to_s.upcase.include?(search_value.to_s.upcase)
    end.any?
  end

  def match_search(data_source_value)
    if data_source_value.is_a?(Array)
      match_search_result_to_type_array(data_source_value)
    else
      data_source_value.to_s.upcase.include?(search_value.to_s.upcase)
    end
  end

  def simple_search(data_source_value)
    data_source_value.to_s == search_value.to_s
  end
end
