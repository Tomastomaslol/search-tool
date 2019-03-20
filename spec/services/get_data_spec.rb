require_relative '../../services/get_data'

describe ParseData do

  let(:intialised_type) { 'users' }
  let(:example_valid_absolute_file_path) {'d:/absolute/file/path.json' }
  let(:example_invalid_absolute_file_path) {'x:/very/bad/file/path/test.json' }
  let(:example_response) { [
    {"_id" => 101, "url" => "http://initech.zendesk.com/api/v2/organizations/101.json"},
    {"_id" => 102, "url" => "http://initech.zendesk.com/api/v2/organizations/102.json"},
    ]
  }

  context 'Given that parsed data is returned' do
   
    before(:each) do
      allow_any_instance_of(described_class).to receive(:parse_read_file){ example_response }
      allow_any_instance_of(described_class).to receive(:read_file) { '' }
    end
   
    subject { described_class.new intialised_type, example_valid_absolute_file_path }

    describe '#get_type' do
      it 'retuns the type when get type is invoked' do
        expect(subject.get_type).to be intialised_type
      end
    end

    describe '#get_all' do
      it 'retuns all returned when invoked' do
        expect(subject.get_all).to eq example_response
      end
    end

    describe '#get_keys' do
      it 'gets all keys in response' do
        expect(subject.get_keys).to eq example_response.map {|response_object| response_object.keys }.flatten.uniq
      end
    end

  end

  context 'Given an invalid file path' do

    describe 'initialize' do
      it 'raises an error' do
        expect { described_class.new intialised_type, example_invalid_absolute_file_path }.to raise_exception(Errno::ENOENT)
      end
    end

  end

  context 'Given invalid JSON' do

    before(:each) do
      allow_any_instance_of(described_class).to receive(:read_file){ 'not valid json' }
    end

    describe 'initialize' do
      it 'raises an error' do
        expect { described_class.new intialised_type, example_valid_absolute_file_path }.to raise_exception(JSON::ParserError)
      end
    end

  end
end