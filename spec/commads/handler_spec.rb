require_relative '../../commands/handler'

describe CommandsHandler do
  let(:stub_higline) { instance_double(HighLine) }
  let(:example_valid_type_of_search) { %w[user mud] }
  let(:example_valid_search_terms) { %w[_id subject] }

  before do
    allow(HighLine).to receive(:new).and_return(stub_higline)
    allow(stub_higline).to receive(:say).and_return('')
    allow(stub_higline).to receive(:ask).and_return('')
  end

  subject { described_class.new }

  describe 'initialize' do
    it 'initialises a valid instance of commands handler' do
      expect(described_class.new).to be_an_instance_of described_class
    end
  end

  describe '#intial_state' do
    it 'says what the question is' do
      subject.intial_state
      expect(stub_higline).to have_received(:say).once
    end

    it 'asks a question' do
      subject.intial_state
      expect(stub_higline).to have_received(:ask).once
    end
  end

  describe '#select_type_of_search' do
    it 'says what the question is' do
      subject.select_type_of_search example_valid_type_of_search
      expect(stub_higline).to have_received(:say).once
    end

    it 'says what the valid inputs are' do
      subject.select_type_of_search example_valid_type_of_search
      expect(stub_higline).to have_received(:say).with(/User/).once
    end

    it 'asks a question' do
      subject.select_type_of_search example_valid_type_of_search
      expect(stub_higline).to have_received(:ask).once
    end
  end

  describe '#select_search_term' do
    it 'says what the question is' do
      subject.select_search_term example_valid_search_terms
      expect(stub_higline).to have_received(:say).once
    end
    it 'says what the valid inputs are' do
      subject.select_search_term example_valid_search_terms
      expect(stub_higline).to have_received(:say).with(/subject/).once
    end

    it 'asks a question' do
      subject.select_search_term example_valid_search_terms
      expect(stub_higline).to have_received(:ask).once
    end
  end

  describe '#select_search_value' do
    it 'asks a question' do
      subject.select_search_value
      expect(stub_higline).to have_received(:ask).once
    end
  end
end
