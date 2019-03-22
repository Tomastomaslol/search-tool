require 'json'

class GetFilePath
  attr_reader :type, :relative_path_to_file

  def initialize(type, relative_path_to_file)
    @type = type
    @relative_path_to_file = relative_path_to_file
    validate_given_input!
  end

  def absolute_file_path
    File.expand_path(get_relative_file_path)
  end

  private

  def string_is_valid?(given_value)
    given_value.respond_to?(:to_str) && !given_value.empty?
  end

  def validate_given_input!
    errors = []
    errors.push("type: '#{type}'") unless string_is_valid?(type)
    errors.push("relative_path_to_file: '#{relative_path_to_file}'") unless
      string_is_valid?(relative_path_to_file)
    raise "Invalid input for GetFilePath Service #{errors.join(', ')}" if errors.any?
  end

  def get_relative_file_path
    File.join(relative_path_to_file, "#{type}.json")
  end
end
