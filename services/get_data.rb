require "json"
require 'byebug'

RELATIVE_PATH_TO_FILES = '../../data'.freeze

class ParseData  

  attr_reader :type, :parsed_response

    def initialize type
      @type = type
      file = read_file
      @parsed_response = parse_read_file file
    end

    def get_type
      @type
    end
    
    def get_all
      @parsed_response
    end

    def get_keys
      unique_keys = []
      @parsed_response.each do | item |
        item.keys.each do | key |
         unique_keys.push(key) unless unique_keys.include? key
        end
      end
      unique_keys
    end

    private

    def relative_file_path
      [RELATIVE_PATH_TO_FILES, "#{type}.json"].join('/')
    end

    def absolute_file_path
      File.expand_path(relative_file_path, __FILE__ || '')
    end

    def read_file
      begin
        File.read absolute_file_path
      rescue Errno::ENOENT e
        raise e
        exit(1)
      end
    end
    
    def parse_read_file file
      JSON.parse(file)
    end 

end  