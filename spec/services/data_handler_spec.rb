require_relative '../../services/data_handler'

describe DataHandler do
  let(:example_type) { 'users' }
  let(:example_valid_absolute_file_path) { 'd:/absolute/file/path.json' }
  let(:example_invalid_absolute_file_path) { 'x:/very/bad/file/path/test.json' }
  let(:example_response) do
    [
      {
        '_id' => 101,
        'name' => 'Mr Name McName',
        'active' => true,
        'url' => 'http://initech.zendesk.com/api/v2/organizations/101.json',
        'tags' => %w[
          lamp
          desk
        ]
      },
      {
        '_id' => 102,
        'name' => 'Mr Test Nameson',
        'active' => true,
        'url' => 'http://initech.zendesk.com/api/v2/organizations/102.json',
        'tags' => %w[
          chair
          desk
        ]
      }
    ]
  end

  context 'Given valid data' do
    before do
      allow_any_instance_of(described_class)
        .to receive(:parse_read_file) { example_response }
      allow_any_instance_of(described_class).to receive(:read_file) { '' }
      allow_any_instance_of(described_class).to receive(:SLIGHTLY_SMARTER_SEARCH) { true }
    end

    subject { described_class.new example_type, example_valid_absolute_file_path }

    describe '#get_type' do
      it 'returns the type when invoked' do
        expect(subject.get_type).to be example_type
      end
    end

    describe '#get_all' do
      it 'returns all returned data when invoked' do
        expect(subject.get_all).to eq example_response
      end
    end

    describe '#get_keys' do
      it 'returns all keys in response data' do
        expect(subject.get_keys).to eq example_response.map(&:keys).flatten.uniq
      end
    end
  end

  context 'Given an invalid file path' do
    describe 'initialize' do
      it 'raises an error' do
        expect do
          described_class.new example_type, example_invalid_absolute_file_path
        end.to raise_exception(Errno::ENOENT)
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
        expect do
          described_class.new example_type, example_valid_absolute_file_path
        end.to raise_exception(JSON::ParserError)
      end
    end
  end
end
