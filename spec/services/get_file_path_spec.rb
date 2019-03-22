require_relative '../../services/get_file_path'

describe GetFilePath do
  let(:valid_example_path) { 'valid/path' }
  let(:valid_type) { 'tickets' }

  context 'Given valid paths and types' do
    describe 'initialize' do
      it 'initialises a valid instance of get file path' do
        expect(described_class.new(valid_type, valid_example_path))
          .to be_an_instance_of described_class
      end
    end

    describe '#absolute_file_path' do
      it 'returns an valid absolute path when invoked' do
        expect(described_class.new(valid_type, valid_example_path).absolute_file_path)
          .to eq File.expand_path("#{valid_example_path}/#{valid_type}.json")
      end
    end
  end

  context 'Given invalid paths or types' do
    describe 'initialize' do
      it 'raises an exception when given an array as type' do
        expect do
          described_class.new([], valid_example_path)
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given an hash as path' do
        expect do
          described_class.new(valid_type, {})
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given an object as type and array as path' do
        expect do
          described_class.new({}, [])
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given an empty string as type' do
        expect do
          described_class.new('', valid_example_path)
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given an empty string as path' do
        expect do
          described_class.new(valid_example_path, '')
        end.to raise_exception RuntimeError
      end
    end
  end
end