require "json"

class GetFilePath  

  attr_reader :type, :relative_path_to_file

    def initialize type, relative_path_to_file
      @type = type
      @relative_path_to_file = relative_path_to_file
      raise get_not_valid_strings_error_message unless given_valid_string?
    end
   
    def absolute_file_path
      File.expand_path(get_relative_file_path)
    end

    private

    def string_is_valid? given_value
      given_value.respond_to?(:to_str) && given_value.length < 0
    end

    def get_not_valid_strings_error_message
      [!string_is_valid?(type) ? "type: #{type}" : "",
       !string_is_valid?(relative_path_to_file) ? "relative_path_to_file: #{relative_path_to_file}" : "",
      "is not valid input to GetFilePath"].reject(&:empty?).join(' ')
    end

    def given_valid_string?
      string_is_valid?(type) && string_is_valid?(relative_path_to_file)
    end 

    def get_relative_file_path
      File.join(relative_path_to_file, "#{type}.json") 
    end

end  