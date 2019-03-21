require_relative '../../services/get_data'

describe ParseData do
  let(:intialised_type) { 'users' }
  let(:example_valid_absolute_file_path) { 'd:/absolute/file/path.json' }
  let(:example_invalid_absolute_file_path) { 'x:/very/bad/file/path/test.json' }
  let(:example_response) do
    [
      { '_id' => 101, 'active' => true, 'url' => 'http://initech.zendesk.com/api/v2/organizations/101.json' },
      { '_id' => 102, 'active' => true, 'url' => 'http://initech.zendesk.com/api/v2/organizations/102.json' }
    ]
  end

  context 'Given valid data' do
    before(:each) do
      allow_any_instance_of(described_class).to receive(:parse_read_file) { example_response }
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
        expect(subject.get_keys).to eq example_response.map(&:keys).flatten.uniq
      end
    end

    describe '#search_for_value' do
      it 'returns a search result if there is a match' do
        expect(subject.search_for_value('_id', '101')).to eq [example_response[0]]
      end

      it 'returns 2 search results if there is 2 matches' do
        expect(subject.search_for_value('active', true)).to eq [example_response[0], example_response[1]]
      end

      it 'returns 0 search results if there is no matches' do
        expect(subject.search_for_value('active', false)).to eq []
      end
    end
  end

  context 'Given an invalid file path' do
    describe 'initialize' do
      it 'raises an error' do
        expect {
          described_class.new intialised_type, example_invalid_absolute_file_path
        }.to raise_exception(Errno::ENOENT)
      end
    end
  end

  context 'Given invalid JSON' do
    before(:each) do
      allow_any_instance_of(described_class)
        .to receive(:read_file) { 'not valid json' }
    end

    describe 'initialize' do
      it 'raises an error' do
        expect {
          described_class.new intialised_type, example_valid_absolute_file_path
        }.to raise_exception(JSON::ParserError)
      end
    end
  end
end
