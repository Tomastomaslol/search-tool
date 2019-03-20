require "json"

class ParseData  

  attr_reader :type, :parsed_response, :absolute_file_path

    def initialize type, absolute_file_path
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
      @parsed_response.each do | item |
        item.keys.each do | key |
         unique_keys.push(key) unless unique_keys.include? key
        end
      end
      unique_keys
    end

    private

    def read_file
      begin
        File.read absolute_file_path
      rescue Errno::ENOENT => e
        #puts "#{absolute_file_path} is not a valid file path please provide a valid file path"
        raise e
      rescue Exception => e
        raise e
      end
    end
    
    def parse_read_file
      begin 
        JSON.parse(read_file)
      rescue Exception => e
        raise e
      end
    end 

end  